library nirsit_plugin;

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:nirsit_plugin/src/data/wifi/wifi_network_info.dart';
import 'package:nirsit_plugin/src/flutter_background_service.dart';
import 'package:nirsit_plugin/src/nirsit/desktop_nirsit_implementation.dart';
import 'package:nirsit_plugin/src/nirsit/mobile_nirsit_implementation.dart';
import 'package:nirsit_plugin/src/nirsit/nirsit_implementation.dart';
import 'package:nirsit_plugin/src/nirsit_plugin_platform_interface.dart';
import 'package:nirsit_plugin/src/utils/logger.dart';
import 'package:nirsit_plugin/src/wifi/wifi_service.dart';
import 'src/data/nirsit_status.dart';
import 'src/data/nirsit_data.dart';
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
export 'src/data/wifi/wifi_network_info.dart';

Future<void> startForegroundService() {
  if (!kIsWeb && (defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS)) {
    return initializeService();
  }
  return Future.value();
}

class NirsitPlugin {
  final wifiService = WifiService();
  late final NirsitImplementation _implementation;

  NirsitConnectionState get nirsitConnectionState => _implementation.connectionState;

  Stream<List<ConnectivityResult>> get connectivityResultStream => wifiService.connectivityResultStream;

  Stream<NirsitData> get nirsitDataStream => _implementation.dataStream;
  Stream<MeasureState> get measureStateStream => _implementation.measureStateStream;
  Stream<NirsitConnectionState> get connectStateStream => _implementation.connectionStateStream;

  bool get isBackgroundSupported => !kIsWeb && (defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS);

  NirsitPlugin() {
    if (isBackgroundSupported) {
      _implementation = MobileNirsitImplementation();
    } else {
      _implementation = DesktopNirsitImplementation();
    }
  }

  void dispose() {
    _implementation.dispose();
  }

  Future<String?> getPlatformVersion() {
    return NirsitPluginPlatform.instance.getPlatformVersion();
  }

  Future<List<WifiNetworkInfo>> scan() => wifiService.scan();

  Future<bool> connectWifi(String ssid, String bssid, String password) => wifiService.connect(ssid, bssid, password);

  Future<String?> getConnectedWifiSsid() => wifiService.getConnectedWifiSsid();

  Future<bool> isWifiConnected() => wifiService.isConnected();

  Future<bool> disconnectWifi() => wifiService.disconnect();

  Future<bool> isWifiEnabled() => wifiService.isWifiEnabled();


  void connectNirsit(String ip, int port) => _implementation.connect(ip, port);

  void startGainCal(int snrLimit) => _implementation.startGainCal(snrLimit);

  void startChannelRejection() => _implementation.startChannelRejection();

  void setSnrLimit(int snrLimit) => _implementation.setSnrLimit(snrLimit);

  void setDSPOptions(int options) => _implementation.setDSPOptions(options);

  void startMeasure() => _implementation.startMeasure();

  void stopMeasure() => _implementation.stopMeasure();

  void stopGainCal() => _implementation.stopGainCal();

  void requestTestCommand() => _implementation.requestTestCommand();

  void requestBatteryInto() => _implementation.requestBatteryInfo();

  Future<void> requestVersion() => _implementation.requestVersion();

  void disconnectNirsit() => _implementation.disconnect();

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
