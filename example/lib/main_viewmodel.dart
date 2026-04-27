

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nirsit_plugin/nirsit_plugin.dart';
import 'package:nirsit_plugin_example/provider/nirsit_provider.dart';
import 'package:nirsit_plugin_example/utils/logger.dart';

final mainViewModel = ChangeNotifierProvider<MainViewModel>((ref) {
  return MainViewModel(ref);
});


class MainViewModel extends ChangeNotifier {
  final _ref;

  NirsitPlugin get _nirsitPlugin => _ref.read(nirsitProvider);

  Stream<NirsitConnectionState> get connectStateStream => _nirsitPlugin.connectStateStream;

  Stream<MeasureState> get measureStateStream => _nirsitPlugin.measureStateStream;

  Stream<NirsitData> get nirsitDataStream => _nirsitPlugin.nirsitDataStream;

  Future<String?> getConnectedWifiSsid() => _nirsitPlugin.getConnectedWifiSsid();

  NirsitConnectionState _connectionState = NirsitConnectionState.disconnected;

  NirsitConnectionState get connectionState => _connectionState;

  MeasureState _measureState = MeasureState.stop;

  MeasureState get measureState => _measureState;

  String _measureStateText = '';
  String get measureStateText => _measureStateText;

  VersionInfo _mainVersion = VersionInfo(version: '');

  VersionInfo get mainVersion => _mainVersion;

  VersionInfo _wifiVersion = VersionInfo(version: '');

  VersionInfo get wifiVersion => _wifiVersion;

  BatteryInfo _batteryInfo = BatteryInfo(status: 0, level: 0);

  BatteryInfo get batteryInfo => _batteryInfo;

  List<WifiNetworkInfo> _wifiList = [];
  List<WifiNetworkInfo> get wifiList => _wifiList;

  MainViewModel(this._ref) {
    connectStateStream.listen((state) {
      _connectionState = state;
      notifyListeners();
    });
    measureStateStream.listen((state) {
      _measureState = state;
      _measureStateText = measureState.name;
      notifyListeners();
    });
  }


  Future<void> disconnect() async {
    _nirsitPlugin.disconnectNirsit();
  }

  Future<bool> connectNirsit() async {
    await disconnect();
    await Future.delayed(const Duration(milliseconds: 100));
    _nirsitPlugin.connectNirsit("192.168.0.1", 50007);
    logger.d("Nirsit is connected? - $connectionState");
    listenNirsitData();
    return connectionState == NirsitConnectionState.connected;
  }

  void listenNirsitData() {
    nirsitDataStream.listen((data) {
      logger.d('listenNirsitData : ${data.data}');
      switch (data.type) {
        case Data.mainVersion:
          _mainVersion = data.data as VersionInfo;
          logger.d('main version : ${_mainVersion.version}');
          break;
        case Data.wifiVersion:
          _wifiVersion = data.data as VersionInfo;
          logger.d('version : ${wifiVersion.version}');
          break;
        case Data.measure:
          var measureData = data.data as MeasureData;
          handleMeasure(measureData);
          break;
        case Data.gainCal:
          var calData = data.data as CalibrationData;
          handleGainCal(calData);
          break;
        case Data.snr:
          var snrData = data.data as SnrData;
          handleSnr(snrData);
          break;
        case Data.batteryInfo:
          _batteryInfo = data.data as BatteryInfo;
          logger.d('$batteryInfo');
          break;
        default:
          logger.d('unknown data type : ${data.type}');
      }
      notifyListeners();
    });
  }

  void handleGainCal(CalibrationData calData) {
    logger.d('calibration progress : ${calData.progress}');
    _measureStateText = '${MeasureState.gainCal.name} : ${calData.progress} %';
    if (calData.progress == 100) {
      startChannelRejection();
    }
  }

  void handleSnr(SnrData snrData) {
    logger.d('snr780 : ${snrData.snr780}');
    logger.d('snr850 : ${snrData.snr850}');
  }

  void handleMeasure(MeasureData measureData) {
    _measureStateText = '${MeasureState.measure.name} : ${measureData.sequence}';
    logger.d('rawData seq : ${measureData.sequence}, data : ${measureData.rawData}');
    logger.d('data780 : ${measureData.data780}');
    logger.d('data850 : ${measureData.data850}');
    logger.d('acc : ${measureData.accX}, ${measureData.accY}, ${measureData.accZ}, gyro : ${measureData.gyroX}, ${measureData.gyroY}, ${measureData.gyroZ}');
    logger.d('battery : ${measureData.battery}');
  }


  Future<void> requestTest() async {
    logger.d("_requestTest");
    _nirsitPlugin.requestTestCommand();
  }

  Future<void> startGainCal() async {
    logger.d("_requestGainCal");
    _nirsitPlugin.startGainCal(30);
  }

  Future<void> startChannelRejection() async {
    logger.d("_startChannelRejection");
    _nirsitPlugin.startChannelRejection();
  }

  Future<void> startMeasure() async {
    logger.d("_requestStartMeasure");
    _nirsitPlugin.setSnrLimit(30);
    _nirsitPlugin.setDSPOptions(0|1);
    _nirsitPlugin.startMeasure();
  }

  Future<void> stopMeasure() async {
    logger.d("_requestStopMeasure");
    _nirsitPlugin.stopMeasure();
  }

  Future<void> getVersion() async {
    logger.d("_getVersion");
    _nirsitPlugin.requestVersion();
  }

  Future<void> requestBatteryInto() async {
    logger.d("_requestBatteryInto");
    _nirsitPlugin.requestBatteryInto();
  }

  bool isNirsitConnected() => connectionState == NirsitConnectionState.connected;

  Future<void> scanWifi() async {
    logger.d("_scanWifi");
    _wifiList.clear();
    final wifiList = await _nirsitPlugin.scan();
    logger.d("_scanWifi : ${wifiList.length}");
    for (var element in wifiList) {
      logger.d("_scanWifi wifi ssid : ${element.ssid} , ${element.bssid}");
      _wifiList.add(element);
    }
    notifyListeners();
  }

  Future<void> connectWifi(String ssid, String bssid, String password) async {
    bool connected = await _nirsitPlugin.wifiService.connect(ssid, bssid, password);
    logger.d("_connectWifi connected : $connected");
  }
}