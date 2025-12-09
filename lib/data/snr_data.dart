
import 'package:freezed_annotation/freezed_annotation.dart';

part 'snr_data.g.dart';
part 'snr_data.freezed.dart';
@freezed
abstract class SnrData with _$SnrData {

  const factory SnrData({
    required int snrLimit,
    required List<int> snr780,
    required List<int> snr850,
  }) = _SnrData;

  factory SnrData.fromJson(Map<String, dynamic> json) => _$SnrDataFromJson(json);
}