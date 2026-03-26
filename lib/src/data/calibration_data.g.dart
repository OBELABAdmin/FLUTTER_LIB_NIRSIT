// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: **

part of 'calibration_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CalibrationData _$CalibrationDataFromJson(Map<String, dynamic> json) =>
    _CalibrationData(
      progress: (json['progress'] as num).toInt(),
      ldGain: (json['ldGain'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      pdGain: (json['pdGain'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$CalibrationDataToJson(_CalibrationData instance) =>
    <String, dynamic>{
      'progress': instance.progress,
      'ldGain': instance.ldGain,
      'pdGain': instance.pdGain,
    };
