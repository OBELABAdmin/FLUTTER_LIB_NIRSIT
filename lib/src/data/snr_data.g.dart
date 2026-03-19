// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: **

part of 'snr_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SnrData _$SnrDataFromJson(Map<String, dynamic> json) => _SnrData(
  index: (json['index'] as num).toInt(),
  snrLimit: (json['snrLimit'] as num).toInt(),
  snr780: (json['snr780'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
  snr850: (json['snr850'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
);

Map<String, dynamic> _$SnrDataToJson(_SnrData instance) => <String, dynamic>{
  'index': instance.index,
  'snrLimit': instance.snrLimit,
  'snr780': instance.snr780,
  'snr850': instance.snr850,
};
