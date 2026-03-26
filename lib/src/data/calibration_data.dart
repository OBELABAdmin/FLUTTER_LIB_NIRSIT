import 'package:freezed_annotation/freezed_annotation.dart';

part 'calibration_data.g.dart';
part 'calibration_data.freezed.dart';

@freezed
abstract class CalibrationData with _$CalibrationData {

  const factory CalibrationData({
    required int progress,
    required List<int> ldGain,
    required List<int> pdGain,
  }) = _CalibrationData;

  factory CalibrationData.fromJson(Map<String, dynamic> json) => _$CalibrationDataFromJson(json);
}