// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: **

part of 'battery_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BatteryInfo _$BatteryInfoFromJson(Map<String, dynamic> json) => _BatteryInfo(
  status: (json['status'] as num).toInt(),
  level: (json['level'] as num).toInt(),
);

Map<String, dynamic> _$BatteryInfoToJson(_BatteryInfo instance) =>
    <String, dynamic>{'status': instance.status, 'level': instance.level};
