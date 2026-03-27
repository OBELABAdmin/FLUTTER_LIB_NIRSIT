
import 'package:freezed_annotation/freezed_annotation.dart';

part 'measure_data.g.dart';
part 'measure_data.freezed.dart';
@freezed
abstract class MeasureData with _$MeasureData {

  const factory MeasureData({
    required int sequence,
    required List<int> rawData,
    required List<double> data780,
    required List<double> data850,
    required int batteryStatus,
    required int battery,
    required int accX,
    required int accY,
    required int accZ,
    required int gyroX,
    required int gyroY,
    required int gyroZ,
  }) = _MeasureData;

  factory MeasureData.fromJson(Map<String, dynamic> json) => _$MeasureDataFromJson(json);
}