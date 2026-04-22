#ifndef FLUTTER_PLUGIN_nirsit_plugin_H_
#define FLUTTER_PLUGIN_nirsit_plugin_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace nirsit_plugin {

class NirsitPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  NirsitPlugin();

  virtual ~NirsitPlugin();

  // Disallow copy and assign.
  NirsitPlugin(const NirsitPlugin&) = delete;
  NirsitPlugin& operator=(const NirsitPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace nirsit_plugin

#endif  // FLUTTER_PLUGIN_nirsit_plugin_H_
