import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'nirsit_plugin_method_channel.dart';


abstract class NirsitPluginPlatform extends PlatformInterface {
  /// Constructs a NirsitPluginPlatform.
  NirsitPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static NirsitPluginPlatform _instance = MethodChannelNirsitPlugin();

  /// The default instance of [NirsitPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelNirsitPlugin].
  static NirsitPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [NirsitPluginPlatform] when
  /// they register themselves.
  static set instance(NirsitPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
