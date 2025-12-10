
import 'dart:typed_data';
import 'package:nirsit_plugin/src/utils/logger.dart';

import '../data/nirsit_command.dart';

const snrDataCount = 40;

Uint8List getHeader({required int command, int payloadLength = 0}) {
  final header = <int>[];
  final length = convertIntToShort(payloadLength);
  header.addAll(startPacket);
  header.add(command);
  header.addAll(length);
  return Uint8List.fromList(header);
}

int getChecksum({required Uint8List header, Uint8List? payload}) {
  final data = <int>[
    ...header,
    if (payload != null) ...payload,
  ];
  final checksum = data.fold(0, (sum, byte) => sum + byte);
  return checksum;
}

Uint8List getGainCalCommand() {
  return getCommand(Command.gainCal);
}

Uint8List getStartMeasureCommand() {
  return getCommand(Command.startMeasure);
}

Uint8List getStopMeasureCommand() {
  return getCommand(Command.stopMeasure);
}

Uint8List getMainVersionCommand() {
  return getCommand(Command.mainVersion);
}

Uint8List getWifiVersionCommand() {
  return getCommand(Command.wifiVersion);
}

Uint8List getBatteryCommand() {
  return getCommand(Command.batteryInfo);
}

Uint8List getCommand(Command command, {Uint8List? payload}) {
  final header = getHeader(command: command.value);
  final checksum = getChecksum(header: header, payload: payload);
  final data = <int>[];
  data.addAll(header);
  if (payload != null) data.addAll(payload);
  data.add(checksum);
  printCommand(data);
  return Uint8List.fromList(data);
}

Uint8List convertIntToShort(int value) {
  final bytes = ByteData(2);
  bytes.setUint16(0, value, Endian.big);
  return bytes.buffer.asUint8List();
}

int convertShortToInt(Uint8List value) {
  final short = value.buffer.asByteData(value.offsetInBytes, value.length).getUint16(0, Endian.big);
  return short.toInt();
}

void printCommand(List<int> command) {
  printBytesToHexString('command', command);
}

void printBytesToHexString(String tag, List<int> data) {
  logger.d('plug-in :  $tag : ${data.map((byte) => byte.toRadixString(16).toUpperCase().padLeft(2,'0')).join(' ')}');
}