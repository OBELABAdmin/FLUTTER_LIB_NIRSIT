library nirsit_plugin;

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:nirsit_plugin/src/data/nirsit_data.dart';
import 'package:nirsit_plugin/src/flutter_background_service.dart';
import 'package:nirsit_plugin/src/nirsit_plugin_platform_interface.dart';
import 'package:nirsit_plugin/src/utils/logger.dart';
import 'package:nirsit_plugin/src/wifi/wifi_service.dart';
import 'src/data/nirsit_status.dart';
import 'src/nirsit/sdk/nirsit_sdk.dart';

export 'package:wifi_scan/wifi_scan.dart';
export 'package:connectivity_plus/connectivity_plus.dart' show ConnectivityResult;
export 'src/data/battery_info.dart';
export 'src/data/version_info.dart';
export 'src/data/measure_data.dart';
export 'src/data/calibration_data.dart';
export 'src/data/snr_data.dart';
export 'src/data/nirsit_data.dart';
export 'src/data/nirsit_status.dart';
export 'src/data/data_enum.dart';

Future<void> startForegroundService() => initializeService();

class NirsitPlugin {
  final wifiService = WifiService();
  final service = FlutterBackgroundService();

  NirsitConnectionState _nirsitConnectionState = NirsitConnectionState.disconnected;
  NirsitConnectionState get nirsitConnectionState => _nirsitConnectionState;

  Stream<List<ConnectivityResult>> get connectivityResultStream => wifiService.connectivityResultStream;

  final StreamController<NirsitData> _dataController = StreamController.broadcast();
  Stream<NirsitData> get nirsitDataStream => _dataController.stream;

  final StreamController<MeasureState> _measureStateController = StreamController.broadcast();
  Stream<MeasureState> get measureStateStream => _measureStateController.stream;

  final StreamController<NirsitConnectionState> _connectionStateController = StreamController.broadcast();
  Stream<NirsitConnectionState> get connectStateStream => _connectionStateController.stream;

  NirsitPlugin() {
    service.on(methodConnectionState).listen((state) {
      try {
        final statName = state?[keyConnectState];
        logger.d("service on connectionState? - $statName");
        _nirsitConnectionState = NirsitConnectionState.values.byName(statName);
        _connectionStateController.add(NirsitConnectionState.values.byName(statName));
      } catch (e, stackTrace) {
        logger.e("service on connectionState?", error: e, stackTrace: stackTrace);
      }
    });
    service.on(methodMeasureState).listen((state) {
      try {
        final statName = state?[keyMeasureState];
        logger.d("service on measureState? - $statName");
        _measureStateController.add(MeasureState.values.byName(statName));
      } catch (e, stackTrace) {
        logger.e("service on measureState?", error: e, stackTrace: stackTrace);
      }
    });
    service.on(methodData).listen((data) {
      logger.d("service on data? - $data");
      try {
        final nirsitData = NirsitData.fromJson(data?[keyData]);
        logger.d("nirsitData? - $nirsitData");
        _dataController.add(nirsitData);
      } catch (e, stackTrace) {
        logger.e("service on data?", error: e, stackTrace: stackTrace);
      }
    });
  }

  void dispose() {
    _dataController.close();
    _measureStateController.close();
    _connectionStateController.close();
  }

  Future<String?> getPlatformVersion() {
    return NirsitPluginPlatform.instance.getPlatformVersion();
  }

  Future<List<WiFiAccessPoint>> scan() => wifiService.scan();

  Future<String?> getConnectedWifiSsid() => wifiService.getConnectedWifiSsid();

  Future<bool> isConnected() => wifiService.isConnected();

  Future<bool> disconnect() => wifiService.disconnect();

  Future<bool> isWifiEnabled() => wifiService.isWifiEnabled();


  void connectNirsit(String ip, int port) => service.invoke(methodConnect, {keyIp: ip, keyPort: port});

  void startGainCal(int snrLimit) => service.invoke(methodGainCal, {keySnrLimit: snrLimit});

  void startChannelRejection() => service.invoke(methodChannelRejection);

  void setSnrLimit(int snrLimit) => service.invoke(methodSetSnrLimit, {keySnrLimit: snrLimit});

  void setDSPOptions(int options) => service.invoke(methodSetOptions, {keyDspOptions: options});

  void startMeasure() => service.invoke(methodMeasure);


  void stopMeasure() => service.invoke(methodStop);

  void stopGainCal() => service.invoke(methodStopGainCal);

  void requestTestCommand() => service.invoke(methodTest);

  void requestBatteryInto() => service.invoke(methodBattery);

  void requestVersion() => service.invoke(methodVersion);

  void disconnectNirsit() => service.invoke(methodDisconnect);

  Future<double> testNirsitSdk() async {
    logger.d('plug-in :  Calling native function: nirsit_sdk_test');
    try {
      final nirsitSdk = NirsitSdk();
      final result = nirsitSdk.test();

      logger.d('plug-in :  Native function from bindings returned: $result');
      return result;
    } catch (e) {
      logger.d('plug-in :  Error calling native function: $e');
      return Future.error('Error calling native function');
    }
  }
}
