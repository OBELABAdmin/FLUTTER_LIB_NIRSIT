import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:nirsit_plugin/src/data/nirsit_command.dart';
import 'package:nirsit_plugin/src/data/nirsit_data.dart';
import 'package:nirsit_plugin/src/data/raw_data.dart';
import 'package:nirsit_plugin/nirsit_plugin.dart';
import 'package:nirsit_plugin/src/nirsit_plugin_method_channel.dart';
import 'package:nirsit_plugin/src/nirsit_plugin_platform_interface.dart';
import 'package:nirsit_plugin/src/utils/packet_parser.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockNirsitPluginPlatform
    with MockPlatformInterfaceMixin
    implements NirsitPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final NirsitPluginPlatform initialPlatform = NirsitPluginPlatform.instance;

  PacketParser parser = PacketParser();

  test('$MethodChannelNirsitPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelNirsitPlugin>());
  });

  test('getPlatformVersion', () async {
    NirsitPlugin nirsitPlugin = NirsitPlugin();
    MockNirsitPluginPlatform fakePlatform = MockNirsitPluginPlatform();
    NirsitPluginPlatform.instance = fakePlatform;

    expect(await nirsitPlugin.getPlatformVersion(), '42');
  });

  test('getBattery', () async {
    final batteryInfo = parser.parseBatteryInfo(
        RawData(
            startPacket: Uint8List.fromList(startPacket),
            dataType: Command.batteryInfo.value,
            length: Uint8List.fromList([0x02, 0x00]),
            payload: Uint8List.fromList([0x01, 0x64]),
            checksum: 0x8F
        ));
    print('batteryInfo: $batteryInfo');
  });

  test('uint8Sublistview', () async {
    final data = Uint8List.fromList([0x00, 0xa0, 0x00, 0x1a, 0x00, 0xA9, 0x00, 0xa0, 0x00, 0x1a, 0x00, 0xA9]);
    final dataView = Uint8List.sublistView(data, 3, 9);
    final lengthView = Uint8List.sublistView(data, 2, 4);

    print('data: ${parser.getLength(lengthView)}');
  });

  test('measure data', () async {
    final dataText = "64 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1F 00";
    final List<int> dataList = dataText.split(' ').map((data) => int.parse(data, radix: 16)).toList();
    print('dataList size = ${dataList.length}');
    final data = Uint8List.fromList(dataList);
    final measureData = parser.parseCalibrationData(data);

    print('$measureData');
  });
}
