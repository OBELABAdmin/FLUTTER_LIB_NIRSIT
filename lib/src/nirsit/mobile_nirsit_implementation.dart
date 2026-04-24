import 'dart:async';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:nirsit_plugin/src/flutter_background_service.dart';
import 'package:nirsit_plugin/src/utils/logger.dart';
import '../data/nirsit_data.dart';
import '../data/nirsit_status.dart';
import '../data/nirsit_command.dart';
import 'nirsit_implementation.dart';

class MobileNirsitImplementation implements NirsitImplementation {
  final _service = FlutterBackgroundService();
  
  final StreamController<NirsitData> _dataController = StreamController.broadcast();
  final StreamController<MeasureState> _measureStateController = StreamController.broadcast();
  final StreamController<NirsitConnectionState> _connectionStateController = StreamController.broadcast();

  NirsitConnectionState _connectionState = NirsitConnectionState.disconnected;

  @override
  Stream<NirsitData> get dataStream => _dataController.stream;
  @override
  Stream<MeasureState> get measureStateStream => _measureStateController.stream;
  @override
  Stream<NirsitConnectionState> get connectionStateStream => _connectionStateController.stream;
  @override
  NirsitConnectionState get connectionState => _connectionState;

  MobileNirsitImplementation() {
    _service.on(methodConnectionState).listen((state) {
      try {
        final statName = state?[keyConnectState];
        _connectionState = NirsitConnectionState.values.byName(statName);
        _connectionStateController.add(_connectionState);
      } catch (e, stackTrace) {
        logger.e("MobileImplementation on connectionState", error: e, stackTrace: stackTrace);
      }
    });

    _service.on(methodMeasureState).listen((state) {
      try {
        final statName = state?[keyMeasureState];
        _measureStateController.add(MeasureState.values.byName(statName));
      } catch (e, stackTrace) {
        logger.e("MobileImplementation on measureState", error: e, stackTrace: stackTrace);
      }
    });

    _service.on(methodData).listen((data) {
      try {
        final nirsitData = NirsitData.fromJson(data?[keyData]);
        _dataController.add(nirsitData);
      } catch (e, stackTrace) {
        logger.e("MobileImplementation on data", error: e, stackTrace: stackTrace);
      }
    });
  }

  @override
  void connect(String ip, int port) => _service.invoke(methodConnect, {keyIp: ip, keyPort: port});

  @override
  void startMeasure() => _service.invoke(methodMeasure);

  @override
  void stopMeasure() => _service.invoke(methodStop);

  @override
  void startGainCal(int snrLimit) => _service.invoke(methodGainCal, {keySnrLimit: snrLimit});

  @override
  void stopGainCal() => _service.invoke(methodStopGainCal);

  @override
  void startChannelRejection() => _service.invoke(methodChannelRejection);

  @override
  void setSnrLimit(int snrLimit) => _service.invoke(methodSetSnrLimit, {keySnrLimit: snrLimit});

  @override
  void setDSPOptions(int options) => _service.invoke(methodSetOptions, {keyDspOptions: options});

  @override
  void requestBatteryInfo() => _service.invoke(methodBattery);

  @override
  Future<void> requestVersion() async => _service.invoke(methodVersion);

  @override
  void requestTestCommand() => _service.invoke(methodTest);

  @override
  void disconnect() => _service.invoke(methodDisconnect);

  @override
  void dispose() {
    _dataController.close();
    _measureStateController.close();
    _connectionStateController.close();
  }
}
