import 'dart:io';

import 'package:flutter/services.dart';
import 'package:nirsit_plugin/src/wifi/wifi_windows.dart';
import 'package:wifi_iot/wifi_iot.dart';
import 'package:nirsit_plugin/src/utils/logger.dart';
import 'package:wifi_scan/wifi_scan.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../data/wifi/wifi_network_info.dart';
export 'package:wifi_scan/wifi_scan.dart' show WiFiAccessPoint;

class WifiService {
  static const _methodChannel = MethodChannel('nirsit_plugin');

  final connectivity = Connectivity();
  Stream<List<ConnectivityResult>> get connectivityResultStream =>
      connectivity.onConnectivityChanged;

  Future<List<WifiNetworkInfo>> scan() async {
    try {
      if (Platform.isWindows) {
        final result = await WifiWindows.scan();
        return Future.value(
          result.where((element) {
            logger.d('plug-in :  ssid: ${element.ssid}');
            return element.ssid.startsWith('NIRSIT');
          }).toList(),
        );
      } else {
        return _scanAndroid();
      }
    } catch (e) {
      throw WifiScanException("Wifi Scan Error $e");
    }
  }

  Future<List<WifiNetworkInfo>> _scanAndroid() async {
    final wifiScan = WiFiScan.instance;
    final canScan = await wifiScan.canStartScan(askPermissions: true);

    if (canScan != CanStartScan.yes) {
      throw WifiScanException(_scanBlockedMessage(canScan));
    }

    final canGetResults = await wifiScan.canGetScannedResults(
      askPermissions: true,
    );
    if (canGetResults != CanGetScannedResults.yes) {
      throw WifiScanException(_scanResultsBlockedMessage(canGetResults));
    }

    final resultsFuture = wifiScan.onScannedResultsAvailable.first
        .timeout(
          const Duration(seconds: 4),
          onTimeout: () => const <WiFiAccessPoint>[],
        )
        .catchError((e) {
          logger.w('plug-in : wifi scan results stream error: $e');
          return const <WiFiAccessPoint>[];
        });

    final started = await wifiScan.startScan();
    logger.d('plug-in : wifi scan started=$started');

    final streamedResults = started
        ? await resultsFuture
        : const <WiFiAccessPoint>[];
    final result = streamedResults.isNotEmpty
        ? streamedResults
        : await wifiScan.getScannedResults();

    return result
        .where((element) {
          logger.d('plug-in :  ssid: ${element.ssid}');
          return element.ssid.startsWith('NIRSIT');
        })
        .map(
          (element) =>
              WifiNetworkInfo(element.ssid, element.bssid, element.level),
        )
        .toList();
  }

  String _scanBlockedMessage(CanStartScan state) {
    switch (state) {
      case CanStartScan.noLocationPermissionRequired:
        return 'Wi-Fi scan requires location permission';
      case CanStartScan.noLocationPermissionDenied:
        return 'Wi-Fi scan location permission was denied. Allow precise location from Android settings.';
      case CanStartScan.noLocationPermissionUpgradeAccuracy:
        return 'Wi-Fi scan requires precise location permission';
      case CanStartScan.noLocationServiceDisabled:
        return 'Wi-Fi scan requires Android Location service to be enabled';
      case CanStartScan.notSupported:
        return 'Wi-Fi scan is not supported on this device';
      case CanStartScan.failed:
        return 'Wi-Fi scan failed to start';
      case CanStartScan.yes:
        return 'Wi-Fi scan is available';
    }
  }

  String _scanResultsBlockedMessage(CanGetScannedResults state) {
    switch (state) {
      case CanGetScannedResults.noLocationPermissionRequired:
        return 'Wi-Fi scan results require location permission';
      case CanGetScannedResults.noLocationPermissionDenied:
        return 'Wi-Fi scan results location permission was denied. Allow precise location from Android settings.';
      case CanGetScannedResults.noLocationPermissionUpgradeAccuracy:
        return 'Wi-Fi scan results require precise location permission';
      case CanGetScannedResults.noLocationServiceDisabled:
        return 'Wi-Fi scan results require Android Location service to be enabled';
      case CanGetScannedResults.notSupported:
        return 'Wi-Fi scan results are not supported on this device';
      case CanGetScannedResults.yes:
        return 'Wi-Fi scan results are available';
    }
  }

  Future<String?> getConnectedWifiSsid() =>
      Platform.isWindows ? WifiWindows.getSSID() : WiFiForIoTPlugin.getSSID();

  Future<Map<String, String?>> getConnectedWifiNetworkInfo() async {
    if (Platform.isWindows) {
      return const <String, String?>{'ip': null, 'gateway': null};
    }

    final result = await _methodChannel.invokeMapMethod<String, String?>(
      'getWifiNetworkInfo',
    );
    return result ?? const <String, String?>{'ip': null, 'gateway': null};
  }

  Future<String?> getConnectedWifiIp() async {
    final info = await getConnectedWifiNetworkInfo();
    return info['ip'];
  }

  Future<String?> getConnectedWifiGateway() async {
    final info = await getConnectedWifiNetworkInfo();
    return info['gateway'];
  }

  Future<bool> isConnected() => Platform.isWindows
      ? WifiWindows.isConnected()
      : WiFiForIoTPlugin.isConnected();

  Future<bool> disconnect() => Platform.isWindows
      ? WifiWindows.disconnect()
      : WiFiForIoTPlugin.disconnect();

  Future<bool> isWifiEnabled() => Platform.isWindows
      ? WifiWindows.isEnabled()
      : WiFiForIoTPlugin.isEnabled();

  Future<bool> registerWifiNetwork(
    String ssid,
    String bssid,
    String password,
  ) async {
    if (Platform.isWindows) return false;
    return await WiFiForIoTPlugin.registerWifiNetwork(
      ssid,
      bssid: bssid,
      password: password,
      security: NetworkSecurity.WPA,
    );
  }

  Future<bool> connect(String ssid, String bssid, String password) async {
    if (Platform.isWindows) {
      try {
        final connected = await WifiWindows.connect(ssid, password);
        logger.d('plug-in : windows connected: $connected');
        return connected;
      } catch (e, st) {
        logger.e('plug-in : windows connect error: $e\n$st');
        throw WifiConnectException("Wifi Connect Error $e");
      }
    }

    logger.d('plug-in : connect req ssid=$ssid bssid=$bssid');
    try {
      final currentSsid = (await WiFiForIoTPlugin.getSSID())?.replaceAll(
        '"',
        '',
      );
      logger.d('plug-in : currentSsid=$currentSsid');
      if (currentSsid != null && currentSsid == ssid) {
        final forced = await WiFiForIoTPlugin.forceWifiUsage(true);
        logger.d('plug-in : already on $ssid, forceWifiUsage=$forced');
        return _verifyIpAssigned();
      }

      bool connected = await _tryConnect(ssid, bssid, password);

      if (!connected) {
        logger.w(
          'plug-in : connect() returned false, falling back to findAndConnect',
        );
        connected = await _tryFindAndConnect(ssid, bssid, password);
      }

      if (!connected) {
        logger.w('plug-in : failed to connect to $ssid');
        return false;
      }

      final verified = await _verifyConnected(ssid);
      if (!verified) {
        logger.w(
          'plug-in : connect() succeeded but SSID did not switch to $ssid within timeout',
        );
        return false;
      }

      final forced = await WiFiForIoTPlugin.forceWifiUsage(true);
      logger.d('plug-in : connected & verified, forceWifiUsage=$forced');
      final hasIp = await _verifyIpAssigned();
      if (!hasIp) {
        logger.w('plug-in : connected but Wi-Fi IP was not assigned');
        return false;
      }
      return true;
    } on PlatformException catch (e, st) {
      logger.e(
        'plug-in : connect PlatformException code=${e.code} message=${e.message} details=${e.details}\n$st',
      );
      throw WifiConnectException(
        "Wifi Connect PlatformException ${e.code}: ${e.message}",
      );
    } catch (e, st) {
      logger.e('plug-in : connect error: $e\n$st');
      throw WifiConnectException("Wifi Connect Error $e");
    }
  }

  Future<bool> _tryConnect(String ssid, String bssid, String password) async {
    try {
      final connected = await WiFiForIoTPlugin.connect(
        ssid,
        bssid: bssid,
        password: password,
        joinOnce: true,
        security: NetworkSecurity.WPA,
        withInternet: false,
      );
      logger.d('plug-in : WiFiForIoTPlugin.connect() => $connected');
      return connected;
    } on PlatformException catch (e) {
      logger.e(
        'plug-in : connect() PlatformException code=${e.code} message=${e.message} details=${e.details}',
      );
      return false;
    }
  }

  Future<bool> _verifyConnected(
    String targetSsid, {
    Duration timeout = const Duration(seconds: 6),
    Duration interval = const Duration(milliseconds: 300),
  }) async {
    final deadline = DateTime.now().add(timeout);
    while (DateTime.now().isBefore(deadline)) {
      final current = (await WiFiForIoTPlugin.getSSID())?.replaceAll('"', '');
      logger.d('plug-in : verify ssid=$current (target=$targetSsid)');
      if (current == targetSsid) return true;
      await Future.delayed(interval);
    }
    return false;
  }

  Future<bool> _verifyIpAssigned({
    Duration timeout = const Duration(seconds: 8),
    Duration interval = const Duration(milliseconds: 300),
  }) async {
    final deadline = DateTime.now().add(timeout);
    while (DateTime.now().isBefore(deadline)) {
      final networkInfo = await getConnectedWifiNetworkInfo();
      final ip = networkInfo['ip'];
      final gateway = networkInfo['gateway'];
      logger.d('plug-in : verify wifi ip=$ip gateway=$gateway');
      if (ip != null && ip.isNotEmpty && ip != '0.0.0.0') {
        return true;
      }
      await Future.delayed(interval);
    }
    return false;
  }

  Future<bool> _tryFindAndConnect(
    String ssid,
    String bssid,
    String password,
  ) async {
    try {
      final connected = await WiFiForIoTPlugin.findAndConnect(
        ssid,
        bssid: bssid,
        password: password,
        joinOnce: true,
        withInternet: false,
      );
      logger.d('plug-in : WiFiForIoTPlugin.findAndConnect() => $connected');
      return connected;
    } on PlatformException catch (e) {
      logger.e(
        'plug-in : findAndConnect() PlatformException code=${e.code} message=${e.message} details=${e.details}',
      );
      return false;
    }
  }
}

class WifiScanException implements Exception {
  final String message;

  WifiScanException(this.message);

  @override
  String toString() {
    return message;
  }
}

class WifiConnectException implements Exception {
  final String message;

  WifiConnectException(this.message);

  @override
  String toString() => message;
}
