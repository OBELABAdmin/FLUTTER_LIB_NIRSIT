// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: **

part of 'measure_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MeasureData _$MeasureDataFromJson(Map<String, dynamic> json) => _MeasureData(
  sequence: (json['sequence'] as num).toInt(),
  data780: (json['data780'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
  data850: (json['data850'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
  batteryStatus: (json['batteryStatus'] as num).toInt(),
  battery: (json['battery'] as num).toInt(),
  accX: (json['accX'] as num).toInt(),
  accY: (json['accY'] as num).toInt(),
  accZ: (json['accZ'] as num).toInt(),
  gyroX: (json['gyroX'] as num).toInt(),
  gyroY: (json['gyroY'] as num).toInt(),
  gyroZ: (json['gyroZ'] as num).toInt(),
);

Map<String, dynamic> _$MeasureDataToJson(_MeasureData instance) =>
    <String, dynamic>{
      'sequence': instance.sequence,
      'data780': instance.data780,
      'data850': instance.data850,
      'batteryStatus': instance.batteryStatus,
      'battery': instance.battery,
      'accX': instance.accX,
      'accY': instance.accY,
      'accZ': instance.accZ,
      'gyroX': instance.gyroX,
      'gyroY': instance.gyroY,
      'gyroZ': instance.gyroZ,
    };
