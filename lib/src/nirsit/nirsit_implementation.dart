import 'dart:async';
import '../data/nirsit_data.dart';
import '../data/nirsit_status.dart';

abstract class NirsitImplementation {
  Stream<NirsitData> get dataStream;
  Stream<MeasureState> get measureStateStream;
  Stream<NirsitConnectionState> get connectionStateStream;
  NirsitConnectionState get connectionState;

  void connect(String ip, int port);
  void startMeasure();
  void stopMeasure();
  void startGainCal(int snrLimit);
  void stopGainCal();
  void startChannelRejection();
  void setSnrLimit(int snrLimit);
  void setDSPOptions(int options);
  void requestBatteryInfo();
  Future<void> requestVersion();
  void requestTestCommand();
  void disconnect();
  void dispose();
}
