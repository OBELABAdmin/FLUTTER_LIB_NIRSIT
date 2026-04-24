import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:win32/win32.dart';

import '../data/wifi/wifi_network_info.dart';

class WifiWindows {
  static Future<List<WifiNetworkInfo>> scan() async {
    final clientHandle = calloc<HANDLE>();
    final negotiatedVersion = calloc<DWORD>();

    final openResult = WlanOpenHandle(
      2,
      nullptr,
      negotiatedVersion,
      clientHandle,
    );

    if (openResult != ERROR_SUCCESS) {
      throw Exception('WlanOpenHandle failed: $openResult');
    }

    final interfaceListPtr = calloc<Pointer<WLAN_INTERFACE_INFO_LIST>>();

    final enumResult = WlanEnumInterfaces(
      clientHandle.value,
      nullptr,
      interfaceListPtr,
    );

    if (enumResult != ERROR_SUCCESS) {
      throw Exception('WlanEnumInterfaces failed: $enumResult');
    }

    final interfaceList = interfaceListPtr.value.ref;

    if (interfaceList.dwNumberOfItems == 0) {
      throw Exception('No WiFi interfaces found');
    }

    // 첫 번째 인터페이스 선택
    final iface = interfaceList.InterfaceInfo[0];

    // ✅ GUID → Pointer<GUID>
    final guidPtr = calloc<GUID>()..ref = iface.InterfaceGuid;

    final bssListPtr = calloc<Pointer<WLAN_BSS_LIST>>();

    // BSSID를 가져오기 위해 WlanGetNetworkBssList 사용
    final bssResult = WlanGetNetworkBssList(
      clientHandle.value,
      guidPtr,
      nullptr,
      dot11_BSS_type_any,
      TRUE,
      nullptr,
      bssListPtr,
    );

    if (bssResult != ERROR_SUCCESS) {
      throw Exception('WlanGetNetworkBssList failed: $bssResult');
    }

    final bssList = bssListPtr.value.ref;
    List<WifiNetworkInfo> networks = [];

    for (int i = 0; i < bssList.dwNumberOfItems; i++) {
      final entry = bssList.wlanBssEntries[i];

      final ssidBytes = entry.dot11Ssid.ucSSID;
      final ssidLength = entry.dot11Ssid.uSSIDLength;

      final ssidList = <int>[];
      for (int j = 0; j < ssidLength; j++) {
        ssidList.add(ssidBytes[j]);
      }
      final ssid = String.fromCharCodes(ssidList);

      // ✅ BSSID (MAC Address) 추출 및 포맷팅
      final bssid = [
        entry.dot11Bssid[0],
        entry.dot11Bssid[1],
        entry.dot11Bssid[2],
        entry.dot11Bssid[3],
        entry.dot11Bssid[4],
        entry.dot11Bssid[5],
      ].map((e) => e.toRadixString(16).padLeft(2, '0').toUpperCase()).join(':');

      final signal = entry.uLinkQuality;

      if (ssid.isNotEmpty) {
        networks.add(WifiNetworkInfo(ssid, bssid, signal));
      }
    }

    // ✅ 메모리 해제
    WlanFreeMemory(bssListPtr.value);
    WlanFreeMemory(interfaceListPtr.value);
    WlanCloseHandle(clientHandle.value, nullptr);

    calloc.free(clientHandle);
    calloc.free(negotiatedVersion);
    calloc.free(guidPtr);

    return networks;
  }

  static Future<bool> connect(String ssid, String password) async {
    final clientHandle = calloc<HANDLE>();
    final negotiatedVersion = calloc<DWORD>();

    WlanOpenHandle(2, nullptr, negotiatedVersion, clientHandle);

    final interfaceListPtr = calloc<Pointer<WLAN_INTERFACE_INFO_LIST>>();
    WlanEnumInterfaces(clientHandle.value, nullptr, interfaceListPtr);

    final iFace = interfaceListPtr.value.ref.InterfaceInfo[0];
    final guidPtr = calloc<GUID>();
    guidPtr.ref = iFace.InterfaceGuid;

    final profileXml = _createProfile(ssid, password).toNativeUtf16();

    final reasonCode = calloc<DWORD>();

    final setProfileResult = WlanSetProfile(
      clientHandle.value,
      guidPtr,
      0,
      profileXml,
      nullptr,
      TRUE,
      nullptr,
      reasonCode,
    );

    if (setProfileResult != ERROR_SUCCESS) {
      print('SetProfile failed: ${reasonCode.value}');
      return false;
    }

    final connectionParams = calloc<WLAN_CONNECTION_PARAMETERS>();

    connectionParams.ref.wlanConnectionMode = wlan_connection_mode_profile;
    connectionParams.ref.strProfile = ssid.toNativeUtf16();
    connectionParams.ref.dot11BssType = dot11_BSS_type_any;
    connectionParams.ref.dwFlags = 0;

    final connectResult = WlanConnect(
      clientHandle.value,
      guidPtr,
      connectionParams,
      nullptr,
    );

    WlanCloseHandle(clientHandle.value, nullptr);

    return connectResult == ERROR_SUCCESS;
  }

  static Future<bool> isConnected() async {
    final clientHandle = calloc<HANDLE>();
    final negotiatedVersion = calloc<DWORD>();

    try {
      final openResult = WlanOpenHandle(
        2,
        nullptr,
        negotiatedVersion,
        clientHandle,
      );

      if (openResult != ERROR_SUCCESS) return false;

      final interfaceListPtr = calloc<Pointer<WLAN_INTERFACE_INFO_LIST>>();
      try {
        final enumResult = WlanEnumInterfaces(
          clientHandle.value,
          nullptr,
          interfaceListPtr,
        );

        if (enumResult != ERROR_SUCCESS) return false;

        final interfaceList = interfaceListPtr.value.ref;
        if (interfaceList.dwNumberOfItems == 0) return false;

        // 첫 번째 인터페이스의 상태 확인
        final iface = interfaceList.InterfaceInfo[0];
        return iface.isState == wlan_interface_state_connected;
      } finally {
        if (interfaceListPtr.value != nullptr) {
          WlanFreeMemory(interfaceListPtr.value);
        }
        calloc.free(interfaceListPtr);
      }
    } finally {
      WlanCloseHandle(clientHandle.value, nullptr);
      calloc.free(clientHandle);
      calloc.free(negotiatedVersion);
    }
  }

  static Future<bool> disconnect() async {
    final clientHandle = calloc<HANDLE>();
    final negotiatedVersion = calloc<DWORD>();

    try {
      final openResult = WlanOpenHandle(2, nullptr, negotiatedVersion, clientHandle);
      if (openResult != ERROR_SUCCESS) return false;

      final interfaceListPtr = calloc<Pointer<WLAN_INTERFACE_INFO_LIST>>();
      try {
        final enumResult = WlanEnumInterfaces(clientHandle.value, nullptr, interfaceListPtr);
        if (enumResult != ERROR_SUCCESS) return false;

        final interfaceList = interfaceListPtr.value.ref;
        if (interfaceList.dwNumberOfItems == 0) return false;

        final iface = interfaceList.InterfaceInfo[0];
        final guidPtr = calloc<GUID>()..ref = iface.InterfaceGuid;

        try {
          final disconnectResult = WlanDisconnect(clientHandle.value, guidPtr, nullptr);
          return disconnectResult == ERROR_SUCCESS;
        } finally {
          calloc.free(guidPtr);
        }
      } finally {
        if (interfaceListPtr.value != nullptr) {
          WlanFreeMemory(interfaceListPtr.value);
        }
        calloc.free(interfaceListPtr);
      }
    } finally {
      WlanCloseHandle(clientHandle.value, nullptr);
      calloc.free(clientHandle);
      calloc.free(negotiatedVersion);
    }
  }

  static Future<bool> isEnabled() async {
    final clientHandle = calloc<HANDLE>();
    final negotiatedVersion = calloc<DWORD>();

    try {
      final openResult = WlanOpenHandle(2, nullptr, negotiatedVersion, clientHandle);
      if (openResult != ERROR_SUCCESS) return false;

      final interfaceListPtr = calloc<Pointer<WLAN_INTERFACE_INFO_LIST>>();
      try {
        final enumResult = WlanEnumInterfaces(clientHandle.value, nullptr, interfaceListPtr);
        if (enumResult != ERROR_SUCCESS) return false;

        final interfaceList = interfaceListPtr.value.ref;
        if (interfaceList.dwNumberOfItems == 0) return false;

        // 인터페이스 상태 확인 (비활성화 상태가 아니면 true)
        final iface = interfaceList.InterfaceInfo[0];
        return iface.isState != wlan_interface_state_not_ready;
      } finally {
        if (interfaceListPtr.value != nullptr) {
          WlanFreeMemory(interfaceListPtr.value);
        }
        calloc.free(interfaceListPtr);
      }
    } finally {
      WlanCloseHandle(clientHandle.value, nullptr);
      calloc.free(clientHandle);
      calloc.free(negotiatedVersion);
    }
  }

  static String _createProfile(String ssid, String password) {
    return '''
      <WLANProfile xmlns="http://www.microsoft.com/networking/WLAN/profile/v1">
        <name>$ssid</name>
        <SSIDConfig>
          <SSID>
            <name>$ssid</name>
          </SSID>
        </SSIDConfig>
        <connectionType>ESS</connectionType>
        <connectionMode>manual</connectionMode>
        <MSM>
          <security>
            <authEncryption>
              <authentication>WPA2PSK</authentication>
              <encryption>AES</encryption>
              <useOneX>false</useOneX>
            </authEncryption>
            <sharedKey>
              <keyType>passPhrase</keyType>
              <protected>false</protected>
              <keyMaterial>$password</keyMaterial>
            </sharedKey>
          </security>
        </MSM>
      </WLANProfile>
     ''';
  }
}
