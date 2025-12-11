import 'package:nirsit_plugin/src/data/calibration_data.dart';
import 'package:nirsit_plugin/src/data/constants.dart';
import 'package:nirsit_plugin/src/data/snr_data.dart';
import 'package:nirsit_plugin/src/data/version_info.dart';

import 'battery_info.dart';
import 'data_enum.dart';
import 'measure_data.dart';


class NirsitData {
  final Data type;
  final dynamic data;

  const NirsitData({
    required this.type,
    required this.data,
  });

  factory NirsitData.fromJson(Map<String, dynamic> json) {
    final typeString = json[keyType] as String;
    final typeEnum = Data.values.byName(typeString);

    final rawData = json[keyData];
    dynamic parsedData;

    if (rawData != null) {
      switch (typeEnum) {
        case Data.batteryInfo:
          parsedData = BatteryInfo.fromJson(rawData as Map<String, dynamic>);
          break;
        case Data.gainCal:
          parsedData = CalibrationData.fromJson(rawData as Map<String, dynamic>);
          break;
        case Data.snr:
          parsedData = SnrData.fromJson(rawData as Map<String, dynamic>);
          break;
        case Data.mainVersion:
        case Data.wifiVersion:
          parsedData = VersionInfo.fromJson(rawData as Map<String, dynamic>);
          break;
        case Data.measure:
          parsedData = MeasureData.fromJson(rawData as Map<String, dynamic>);
          break;
        default:
          parsedData = rawData;
      }
    }

    return NirsitData(
      type: typeEnum,
      data: parsedData,
    );
  }

  Map<String, dynamic> toJson() {
    dynamic encodedData;
    if (data != null) {
      switch (type) {
        case Data.batteryInfo:
          encodedData = (data as BatteryInfo).toJson();
          break;
        case Data.gainCal:
          encodedData = (data as CalibrationData).toJson();
          break;
        case Data.snr:
          encodedData = (data as SnrData).toJson();
          break;
        case Data.mainVersion:
        case Data.wifiVersion:
          encodedData = (data as VersionInfo).toJson();
          break;
        case Data.measure:
          encodedData = (data as MeasureData).toJson();
          break;
        default:
          encodedData = data;
      }
    }

    return {
      keyType: type.name, // Convert Enum to String (e.g., "batteryInfo")
      keyData: encodedData,
    };
  }
}