
import 'package:wifi_iot/wifi_iot.dart';
import 'package:nirsit_plugin/src/utils/logger.dart';
import 'package:wifi_scan/wifi_scan.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
export 'package:wifi_scan/wifi_scan.dart' show WiFiAccessPoint;

class WifiService {

  final connectivity = Connectivity();
  Stream<List<ConnectivityResult>> get connectivityResultStream => connectivity.onConnectivityChanged;

  Future<List<WiFiAccessPoint>> scan() async {
    final wifiScan = WiFiScan.instance;
    final canScan = await wifiScan.canStartScan(askPermissions: true);

    if (canScan != CanStartScan.yes) {
      throw WifiScanException(canScan.toString());
    }
    await wifiScan.startScan();

    try {
      final result = await wifiScan.getScannedResults();
      return Future.value(result.where((element) {
        logger.d('plug-in :  ssid: ${element.ssid}');
        return element.ssid.startsWith('NIRSIT');
      }).toList());
    } catch (e) {
      throw WifiScanException("Wifi Scan Error $e");
    }
  }

  Future<String?> getConnectedWifiSsid() async {
    return await WiFiForIoTPlugin.getSSID();
  }

  Future<bool> isConnected() async {
    return await WiFiForIoTPlugin.isConnected();
  }

  Future<bool> disconnect() async {
    return await WiFiForIoTPlugin.disconnect();
  }

  Future<bool> isWifiEnabled() async {
    return await WiFiForIoTPlugin.isEnabled();
  }

  Future<bool> registerWifiNetwork(String ssid, String bssid, String password) async {
    return await WiFiForIoTPlugin.registerWifiNetwork(ssid, bssid: bssid, password: password,security: NetworkSecurity.WPA);
  }

  Future<bool> connect(String ssid, String bssid, String password) async {
    logger.d('plug-in :  ssid: $ssid, password: $password');
    return await WiFiForIoTPlugin
        .connect(ssid, bssid: bssid, password: password, joinOnce: false, security: NetworkSecurity.WPA, withInternet: false);
  }
}

class WifiScanException implements Exception {
  final String message;

  WifiScanException(this.message);

  @override
  String toString(){
    return message;
  }
}