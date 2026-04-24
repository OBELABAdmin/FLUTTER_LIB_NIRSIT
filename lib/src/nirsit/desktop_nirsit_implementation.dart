import 'dart:async';

import '../data/nirsit_data.dart';
import '../data/nirsit_status.dart';
import '../data/nirsit_command.dart';
import 'nirsit_implementation.dart';
import 'nirsit_service.dart';

class DesktopNirsitImplementation implements NirsitImplementation {
  final NirsitService _nirsitService = NirsitService();

  @override
  Stream<NirsitData> get dataStream => _nirsitService.dataStream;
  @override
  Stream<MeasureState> get measureStateStream => _nirsitService.measureStateStream;
  @override
  Stream<NirsitConnectionState> get connectionStateStream => _nirsitService.connectionStateStream;
  @override
  NirsitConnectionState get connectionState => _nirsitService.connectState;

  @override
  void connect(String ip, int port) => _nirsitService.connect(ip, port);

  @override
  void startMeasure() => _nirsitService.startMeasure();

  @override
  void stopMeasure() => _nirsitService.stopMeasure();

  @override
  void startGainCal(int snrLimit) => _nirsitService.startGainCal(snrLimit: snrLimit);

  @override
  void stopGainCal() => _nirsitService.stopMeasure();

  @override
  void startChannelRejection() => _nirsitService.startChannelRejection();

  @override
  void setSnrLimit(int snrLimit) => _nirsitService.setSnrLimit(snrLimit);

  @override
  void setDSPOptions(int options) => _nirsitService.setDSPOptions(options);

  @override
  void requestBatteryInfo() => _nirsitService.getBatteryInfo();

  @override
  Future<void> requestVersion() async {
    await _nirsitService.getVersion(ReceivedDataType.mainVersion);
    await Future.delayed(const Duration(milliseconds: 500));
    await _nirsitService.getVersion(ReceivedDataType.wifiVersion);
  }

  @override
  void requestTestCommand() => _nirsitService.sendTestCommand();

  @override
  void disconnect() => _nirsitService.disconnect();

  @override
  void dispose() {
    // CoreService is singleton
  }
}
