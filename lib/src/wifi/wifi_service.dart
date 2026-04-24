
import 'dart:io';

import 'package:nirsit_plugin/src/wifi/wifi_windows.dart';
import 'package:wifi_iot/wifi_iot.dart';
import 'package:nirsit_plugin/src/utils/logger.dart';
import 'package:wifi_scan/wifi_scan.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../data/wifi/wifi_network_info.dart';
export 'package:wifi_scan/wifi_scan.dart' show WiFiAccessPoint;

class WifiService {

  final connectivity = Connectivity();
  Stream<List<ConnectivityResult>> get connectivityResultStream => connectivity.onConnectivityChanged;

  Future<List<WifiNetworkInfo>> scan() async {
    try {
      if (Platform.isWindows) {
        final result = await WifiWindows.scan();
        return Future.value(result.where((element) {
          logger.d('plug-in :  ssid: ${element.ssid}');
          return element.ssid.startsWith('NIRSIT');
        }).toList());
      } else {
        final wifiScan = WiFiScan.instance;
        final canScan = await wifiScan.canStartScan(askPermissions: true);

        if (canScan != CanStartScan.yes) {
          throw WifiScanException(canScan.toString());
        }
        await wifiScan.startScan();

        final result = await wifiScan.getScannedResults();
        return Future.value(result.where((element) {
          logger.d('plug-in :  ssid: ${element.ssid}');
          return element.ssid.startsWith('NIRSIT');
        }).map((element) => WifiNetworkInfo(element.ssid, element.bssid, element.level)).toList());
      }
    } catch (e) {
      throw WifiScanException("Wifi Scan Error $e");
    }
  }

  Future<String?> getConnectedWifiSsid() async {
    return await WiFiForIoTPlugin.getSSID();
  }

  Future<bool> isConnected() => Platform.isWindows ? WifiWindows.isConnected() : WiFiForIoTPlugin.isConnected();

  Future<bool> disconnect() => Platform.isWindows ? WifiWindows.disconnect() : WiFiForIoTPlugin.disconnect();

  Future<bool> isWifiEnabled() => Platform.isWindows ? WifiWindows.isEnabled() : WiFiForIoTPlugin.isEnabled();

  Future<bool> registerWifiNetwork(String ssid, String bssid, String password) async {
    if (Platform.isWindows) return false;
    return await WiFiForIoTPlugin.registerWifiNetwork(ssid, bssid: bssid, password: password,security: NetworkSecurity.WPA);
  }

  Future<bool> connect(String ssid, String bssid, String password) async {
    if (Platform.isWindows) {
      final connected = await WifiWindows.connect(ssid, password);
      logger.d('plug-in : windows connected: $connected');
      return connected;
    } else {
      logger.d('plug-in :  ssid: $ssid, password: $password');
      bool connected = await WiFiForIoTPlugin
          .connect(ssid, bssid: bssid, password: password, joinOnce: false, security: NetworkSecurity.WPA, withInternet: false);
      bool forceWifiUsage = await WiFiForIoTPlugin.forceWifiUsage(true);
      logger.d('plug-in :  connected: $connected, forceWifiUsage: $forceWifiUsage');
      return connected;
    }
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