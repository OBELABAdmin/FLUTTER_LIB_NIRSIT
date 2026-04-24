class WifiNetworkInfo {
  final String ssid;
  final String bssid;
  final int signal;

  WifiNetworkInfo(this.ssid, this.bssid, this.signal);

  @override
  String toString() => 'WifiNetwork(ssid: $ssid, bssid: $bssid, signal: $signal%)';
}