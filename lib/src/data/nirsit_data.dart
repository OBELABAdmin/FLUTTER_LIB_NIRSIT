import 'package:nirsit_plugin/src/data/calibration_data.dart';
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
    final typeString = json['type'] as String;
    final typeEnum = Data.values.byName(typeString);

    // 2) data 필드 가져오기
    final rawData = json['data'];
    dynamic parsedData;

    // 3) type에 따라 알맞은 클래스로 변환
    if (rawData != null) {
      switch (typeEnum) {
        case Data.batteryInfo:
        // BatteryInfo로 변환
          parsedData = BatteryInfo.fromJson(rawData as Map<String, dynamic>);
          break;
        case Data.gainCal:
        // HbO2Data로 변환
          parsedData = CalibrationData.fromJson(rawData as Map<String, dynamic>);
          break;
        case Data.snr:
        // HbO2Data로 변환
          parsedData = SnrData.fromJson(rawData as Map<String, dynamic>);
          break;
        case Data.mainVersion:
        case Data.wifiVersion:
        // HbO2Data로 변환
          parsedData = VersionInfo.fromJson(rawData as Map<String, dynamic>);
          break;
        case Data.measure:
          parsedData = MeasureData.fromJson(rawData as Map<String, dynamic>);
          break;
        default:
        // 정의되지 않은 타입은 그대로 둠 (Map or primitive)
          parsedData = rawData;
      }
    }

    // 4) 생성자를 호출하여 반환
    return NirsitData(
      type: typeEnum,
      data: parsedData,
    );
  }

  Map<String, dynamic> toJson() {
    dynamic encodedData;
    // data가 null이 아닐 때만 변환 시도
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
      'type': type.name, // Enum을 String으로 변환 (예: "batteryInfo")
      'data': encodedData,
    };
  }
}