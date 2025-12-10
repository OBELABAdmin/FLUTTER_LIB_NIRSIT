import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'nirsit_plugin_platform_interface.dart';


/// An implementation of [NirsitPluginPlatform] that uses method channels.
class MethodChannelNirsitPlugin extends NirsitPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('nirsit_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
