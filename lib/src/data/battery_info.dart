
import 'package:freezed_annotation/freezed_annotation.dart';

part 'battery_info.g.dart';
part 'battery_info.freezed.dart';
@freezed
abstract class BatteryInfo with _$BatteryInfo {
  const factory BatteryInfo({
    required int status,
    required int level
  }) = _BatteryInfo;

  factory BatteryInfo.fromJson(Map<String, dynamic> json) => _$BatteryInfoFromJson(json);
}