import 'dart:async';
import 'dart:convert';

import 'dart:io';
import 'dart:typed_data';


import 'package:flutter/foundation.dart';

import '../data/data_enum.dart';
import '../data/measure_data.dart';
import '../data/nirsit_data.dart';
import '../data/nirsit_command.dart';
import '../data/nirsit_status.dart';
import '../data/raw_data.dart';
import '../data/snr_data.dart';
import '../utils/logger.dart';
import '../utils/nirsit_command_utils.dart';
import '../utils/packet_parser.dart';
import 'sdk/nirsit_sdk.dart';

@internal
class NirsitService {

  static final NirsitService _instance = NirsitService._internals();
  factory NirsitService() => _instance;
  NirsitService._internals();

  final NirsitSdk _nirsitSdk = NirsitSdk();

  String _ip = "";
  int _port = 0;
  Socket? _socket;

  NirsitConnectionState _connectState = NirsitConnectionState.disconnected;

  NirsitConnectionState get connectState => _connectState;

  MeasureState _measureState = MeasureState.stop;

  MeasureState get measureState => _measureState;

  bool _testCommand = false;

  final _connectionStateController = StreamController<NirsitConnectionState>.broadcast();
  Stream<NirsitConnectionState> get connectionStateStream => _connectionStateController.stream;

  final _dataController = StreamController<NirsitData>.broadcast();
  Stream<NirsitData> get dataStream => _dataController.stream;

  final _measureStateController = StreamController<MeasureState>.broadcast();
  Stream<MeasureState> get measureStateStream => _measureStateController.stream;

  BytesBuilder bytesBuilder = BytesBuilder(copy: false);

  int totalChannelRejectCount = 0;
  int snrCount = 0;

  Function(Uint8List) get onReceived => (data) {
    if (_testCommand) {
      logger.d('plug-in :  test data = ${String.fromCharCodes(data)}');
      _testCommand = false;
    } else {
      logger.d('plug-in :  data = ${data.length}');
      bytesBuilder.add(data);
      _processBuffer(bytesBuilder);
    }
  };

  Function(dynamic) get onError => (error) {
    logger.e('plug-in :error: $error');
    _updateMeasureState(MeasureState.stop);
    _updateConnectionState(NirsitConnectionState.disconnected);
    bytesBuilder.clear();
  };

  Function() get onDone => () {
    _updateMeasureState(MeasureState.stop);
    _updateConnectionState(NirsitConnectionState.disconnected);
    bytesBuilder.clear();
    disconnect();
    logger.e('plug-in :onDone');
  };

  void _processBuffer(BytesBuilder builder) {
    Uint8List chunks = builder.takeBytes();
    int offset = 0;
    while (true) {
      int remaining = chunks.length - offset;
      if (remaining < headerSize) break;
      final startBytes = Uint8List.sublistView(chunks, offset, offset + startPacket.length);
      if (!packetParser.isPacket(startBytes)) {
        offset++;
        logger.d('plug-in :  Invalid start packet!');
        continue;
      }
      final lengthBytes = Uint8List.sublistView(chunks, offset + 4, offset + headerSize);
      final payloadLength = packetParser.getLength(lengthBytes);
      final totalPacketSize = headerSize + payloadLength + 1;

      if (remaining < totalPacketSize) break;

      try {
        final packetData = Uint8List.sublistView(chunks, offset, offset + totalPacketSize);
        final nirsitData = RawData.fromBytes(packetData);
        handleData(nirsitData);
      } catch(e) {
        logger.e('plug-in :❌ parsing error : $e');
      }

      offset += totalPacketSize;
    }

    if (offset < chunks.length) {
      final leftover = chunks.sublist(offset);
      builder.add(leftover);
    }
  }


  Future<NirsitConnectionState> connect(String ip, int port) async {
    _ip = ip;
    _port = port;
    _socket = await Socket.connect(ip, port, timeout: Duration(seconds: 20));
    _socket!.setOption(SocketOption.tcpNoDelay, true);
    _socket?.listen(onReceived, onError: onError, onDone: onDone);
    logger.d('plug-in :  _socket $_socket');
    if (_socket != null) {
      _updateConnectionState(NirsitConnectionState.connected);
    }
    return connectState;
  }

  bool isConnected() => _connectState == NirsitConnectionState.connected;

  Future<void> disconnect() async {
    try {
      await _socket?.close();
    } on SocketException catch (exception) {
      logger.d('plug-in :  SocketException closing socket: $exception');
    } catch (exception) {
      logger.d('plug-in :  Unexpected error closing socket: $exception');
    } finally {
      _socket = null;
      _updateConnectionState(NirsitConnectionState.disconnected);
      _nirsitSdk.clear();
    }
  }

  Future<void> send(Uint8List message) async {
    logger.d('plug-in :  sending: $message');
    logger.d('plug-in :  Sending: ${message.map((b) => b.toRadixString(16).toUpperCase().padLeft(2,'0')).join(' ')}');
    _socket?.add(message);
    _socket?.flush();
  }

  Future<void> sendString(String message) async {
    logger.d('plug-in :  sending: $message');
    await send(utf8.encode(message));
  }

  Future<void> sendTestCommand() async {
    _testCommand = true;
    final sdkTest = _nirsitSdk.test();
    logger.d('plug-in :  sdk test $sdkTest');
    await sendString('t');
  }

  void handleData(RawData data) {
    if (!packetParser.isChecksumValid(data)) {
      logger.e('plug-in :checksum invalid - calc = ${packetParser.calculateChecksum(data)}, checksum = ${data.checksum}');
      return;
    }
    NirsitData? nirsitData;
    switch (data.dataType) {
      case final value when value == ReceivedDataType.measure.value: {
        final measureData = packetParser.parseMeasureData(data.payload);
        // logger.d('plug-in :  $measureData');
        if (_measureState == MeasureState.channelRejection) {
          if (channelRejectionCount >= snrDataCount) {
            channelRejectionCompleted();
            nirsitData = getSnr();
          } else {
            logger.d('plug-in :  channelRejectionCount = $channelRejectionCount');
            handleChannelRejection(measureData);
            totalChannelRejectCount++;
          }
        }
        if (_measureState == MeasureState.measure) {
          // handleMeasure(measureData);
          nirsitData = NirsitData(type: Data.measure, data: measureData);
        }
      }
      break;
      case final value when value == ReceivedDataType.gainCal.value: {
        final calData = packetParser.parseCalibrationData(data.payload);
        logger.d('plug-in :  $calData');
        nirsitData = NirsitData(type: Data.gainCal, data: calData);
        if (calData.progress == 100) {
          logger.d('plug-in :  progress = ${calData.progress} - calibration completed');
        }
      }
      break;
      case final value when value == ReceivedDataType.gainCalCompleted.value: {
        printBytesToHexString('gainCalCompleted', data.payload);
      }
      break;
      case final value when value == ReceivedDataType.mainVersion.value:
      case final value when value == ReceivedDataType.wifiVersion.value: {
        final version = packetParser.parseVersion(data);
        logger.d('plug-in :  $version');
        if (data.dataType == ReceivedDataType.mainVersion.value) {
          nirsitData = NirsitData(type: Data.mainVersion, data: version);
        } else {
          nirsitData = NirsitData(type: Data.wifiVersion , data: version);
        }
    }
      break;
      case final value when value == ReceivedDataType.batteryInfo.value: {
        final batteryInfo = packetParser.parseBatteryInfo(data);
        logger.d('plug-in :  $batteryInfo');
        nirsitData = NirsitData(type: Data.batteryInfo, data: batteryInfo);
      }
      break;
      default:
        logger.d('plug-in :  unknown dataType: ${data.dataType}');
    }
    if (nirsitData != null) _dataController.add(nirsitData);
  }

  void handleChannelRejection(MeasureData measureData, {int snrLimit = 30}) {
    List<double> data780 = measureData.data780.map((data) => data.toDouble()).toList();
    List<double> data850 = measureData.data850.map((data) => data.toDouble()).toList();
    _nirsitSdk.calibration(data780, data850);
  }

  void handleMeasure(MeasureData data) async {
    List<double> data780 = data.data780.map((data) => data.toDouble()).toList();
    List<double> data850 = data.data850.map((data) => data.toDouble()).toList();
    final (hbo2, hbr) = await _nirsitSdk.measure(data780, data850);
    logger.d('plug-in :  hbo2 = ${hbo2}');
    logger.d('plug-in :  hbr = ${hbr}');
  }

  void _updateMeasureState(MeasureState state) {
    _measureState = state;
    _measureStateController.add(measureState);
  }

  void _updateConnectionState(NirsitConnectionState state) {
    _connectState = state;
    _connectionStateController.add(connectState);
  }

  void setDSPOptions(int options) {
    _nirsitSdk.setDSPOption(options);
  }

  void setSnrLimit(int snrLimit) {
    _nirsitSdk.setSnrLimit(snrLimit);
  }


  NirsitData getSnr({int snrLimit = 30}) {
    final (snr780, snr850) = _nirsitSdk.getSnr(snrLimit);
    final snr = SnrData(snrLimit: snrLimit, snr780: snr780, snr850: snr850);
    _nirsitSdk.clear();
    return NirsitData(type: Data.snr, data: snr);
  }

  Future<void> startGainCal({int snrLimit = 30}) async {
    _nirsitSdk.clear();
    _updateMeasureState(MeasureState.gainCal);
    var command = getGainCalCommand();
    await send(command);
  }

  Future<void> startMeasure() async {
    _nirsitSdk.clear();
    setSnrLimit(30);
    _updateMeasureState(MeasureState.measure);
    var command = getStartMeasureCommand();
    await send(command);
  }

  Future<void> stopMeasure() async {
    _updateMeasureState(MeasureState.stop);
    var command = getStopMeasureCommand();
    await send(command);
    _nirsitSdk.clear();
  }

  Future<void> startChannelRejection() async {
    logger.d('plug-in :  _startChannelRejection');
    _updateMeasureState(MeasureState.channelRejection);
    _nirsitSdk.initChannelRejectFlag();
    _nirsitSdk.setSnrLimit(30);
    var command = getStartMeasureCommand();
    await send(command);
  }

  Future<void> channelRejectionCompleted() async {
    _updateMeasureState(MeasureState.stop);
    totalChannelRejectCount = 0;
    snrCount = 0;
    await stopMeasure();
    await Future.delayed(Duration(seconds: 1));
    _nirsitSdk.clear();
  }

  Future<void> getVersion(ReceivedDataType type) async {
    var command = switch (type) {
      ReceivedDataType.mainVersion => getMainVersionCommand(),
      ReceivedDataType.wifiVersion => getWifiVersionCommand(),
      _ => getMainVersionCommand()
    };
    await send(command);
  }

  Future<void>  getBatteryInfo() async {
    var command = getBatteryCommand();
    await send(command);
  }

}