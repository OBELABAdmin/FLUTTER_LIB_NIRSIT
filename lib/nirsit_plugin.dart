library nirsit_plugin;

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:nirsit_plugin/src/data/nirsit_command.dart';
import 'package:nirsit_plugin/src/data/nirsit_data.dart';
import 'package:nirsit_plugin/src/flutter_background_service.dart';
import 'package:nirsit_plugin/src/nirsit/nirsit_service.dart';
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
  FlutterBackgroundService? _service;
  NirsitService? _nirsitService;

  NirsitConnectionState _nirsitConnectionState = NirsitConnectionState.disconnected;
  NirsitConnectionState get nirsitConnectionState => _nirsitConnectionState;

  Stream<List<ConnectivityResult>> get connectivityResultStream => wifiService.connectivityResultStream;

  final StreamController<NirsitData> _dataController = StreamController.broadcast();
  Stream<NirsitData> get nirsitDataStream => _dataController.stream;

  final StreamController<MeasureState> _measureStateController = StreamController.broadcast();
  Stream<MeasureState> get measureStateStream => _measureStateController.stream;

  final StreamController<NirsitConnectionState> _connectionStateController = StreamController.broadcast();
  Stream<NirsitConnectionState> get connectStateStream => _connectionStateController.stream;

  bool get isBackgroundSupported => !kIsWeb && (defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS);

  NirsitPlugin() {
    if (isBackgroundSupported) {
      _service = FlutterBackgroundService();
      _service?.on(methodConnectionState).listen((state) {
        try {
          final statName = state?[keyConnectState];
          logger.d("service on connectionState? - $statName");
          _nirsitConnectionState = NirsitConnectionState.values.byName(statName);
          _connectionStateController.add(NirsitConnectionState.values.byName(statName));
        } catch (e, stackTrace) {
          logger.e("service on connectionState?", error: e, stackTrace: stackTrace);
        }
      });
      _service?.on(methodMeasureState).listen((state) {
        try {
          final statName = state?[keyMeasureState];
          logger.d("service on measureState? - $statName");
          _measureStateController.add(MeasureState.values.byName(statName));
        } catch (e, stackTrace) {
          logger.e("service on measureState?", error: e, stackTrace: stackTrace);
        }
      });
      _service?.on(methodData).listen((data) {
        logger.d("service on data? - $data");
        try {
          final nirsitData = NirsitData.fromJson(data?[keyData]);
          logger.d("nirsitData? - $nirsitData");
          _dataController.add(nirsitData);
        } catch (e, stackTrace) {
          logger.e("service on data?", error: e, stackTrace: stackTrace);
        }
      });
    } else {
      _nirsitService = NirsitService();
      _nirsitService?.connectionStateStream.listen((state) {
        try {
          logger.d("connectionState? - $state");
          _nirsitConnectionState = state;
          _connectionStateController.add(state);
        } catch (e, stackTrace) {
          logger.e("connectionState?", error: e, stackTrace: stackTrace);
        }
      });
      _nirsitService?.measureStateStream.listen((state) {
        try {
          logger.d("measureState? - $state");
          _measureStateController.add(state);
        } catch (e, stackTrace) {
          logger.e("measureState?", error: e, stackTrace: stackTrace);
        }
      });
      _nirsitService?.dataStream.listen((data) {
        try {
          logger.d("nirsitData? - $data");
          _dataController.add(data);
        } catch (e, stackTrace) {
          logger.e("nirsitData?", error: e, stackTrace: stackTrace);
        }
      });
    }
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

  Future<bool> connectWifi(String ssid, String bssid, String password) => wifiService.connect(ssid, bssid, password);

  Future<String?> getConnectedWifiSsid() => wifiService.getConnectedWifiSsid();

  Future<bool> isWifiConnected() => wifiService.isConnected();

  Future<bool> disconnectWifi() => wifiService.disconnect();

  Future<bool> isWifiEnabled() => wifiService.isWifiEnabled();


  void connectNirsit(String ip, int port) {
    if (isBackgroundSupported) {
      _service?.invoke(methodConnect, {keyIp: ip, keyPort: port});
    } else {
      _nirsitService?.connect(ip, port);
    }
  }

  void startGainCal(int snrLimit) {
    if (isBackgroundSupported) {
      _service?.invoke(methodGainCal, {keySnrLimit: snrLimit});
    } else {
      _nirsitService?.startGainCal(snrLimit: snrLimit);
    }
  }

  void startChannelRejection() {
    if (isBackgroundSupported) {
      _service?.invoke(methodChannelRejection);
    } else {
      _nirsitService?.startChannelRejection();
    }
  }

  void setSnrLimit(int snrLimit) {
    if (isBackgroundSupported) {
      _service?.invoke(methodSetSnrLimit, {keySnrLimit: snrLimit});
    } else {
      _nirsitService?.setSnrLimit(snrLimit);
    }
  }

  void setDSPOptions(int options) {
    if (isBackgroundSupported) {
      _service?.invoke(methodSetOptions, {keyDspOptions: options});
    } else {
      _nirsitService?.setDSPOptions(options);
    }
  }

  void startMeasure() {
    if (isBackgroundSupported) {
      _service?.invoke(methodMeasure);
    } else {
      _nirsitService?.startMeasure();
    }
  }


  void stopMeasure() {
    if (isBackgroundSupported) {
      _service?.invoke(methodStop);
    } else {
      _nirsitService?.stopMeasure();
    }
  }

  void stopGainCal() {
    if (isBackgroundSupported) {
      _service?.invoke(methodStopGainCal);
    } else {
      _nirsitService?.stopMeasure();
    }
  }

  void requestTestCommand() {
    if (isBackgroundSupported) {
      _service?.invoke(methodTest);
    } else {
      _nirsitService?.sendTestCommand();
    }
  }

  void requestBatteryInto() {
    if (isBackgroundSupported) {
      _service?.invoke(methodBattery);
    } else {
      _nirsitService?.getBatteryInfo();
    }
  }

  Future<void> requestVersion() async {
    if (isBackgroundSupported) {
      _service?.invoke(methodVersion);
    } else {
      await _nirsitService?.getVersion(ReceivedDataType.mainVersion);
      await Future.delayed(const Duration(milliseconds: 500));
      await _nirsitService?.getVersion(ReceivedDataType.wifiVersion);
    }
  }

  void disconnectNirsit() {
    if (isBackgroundSupported) {
      _service?.invoke(methodDisconnect);
    } else {
      _nirsitService?.disconnect();
    }
  }

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
