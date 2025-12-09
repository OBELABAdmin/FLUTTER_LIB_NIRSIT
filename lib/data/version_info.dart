
import 'package:freezed_annotation/freezed_annotation.dart';

part 'version_info.g.dart';
part 'version_info.freezed.dart';
@freezed
abstract class VersionInfo with _$VersionInfo {

  const factory VersionInfo({
    required String version,
  }) = _VersionInfo;

  factory VersionInfo.fromJson(Map<String, dynamic> json) => _$VersionInfoFromJson(json);
}