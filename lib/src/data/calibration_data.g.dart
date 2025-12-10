// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: **

part of 'calibration_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CalibrationData _$CalibrationDataFromJson(Map<String, dynamic> json) =>
    _CalibrationData(
      progress: (json['progress'] as num).toInt(),
      ld780: (json['ld780'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      ld850: (json['ld850'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      pdStage1: (json['pdStage1'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      pdStage2: (json['pdStage2'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$CalibrationDataToJson(_CalibrationData instance) =>
    <String, dynamic>{
      'progress': instance.progress,
      'ld780': instance.ld780,
      'ld850': instance.ld850,
      'pdStage1': instance.pdStage1,
      'pdStage2': instance.pdStage2,
    };
