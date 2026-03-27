
import 'package:freezed_annotation/freezed_annotation.dart';

import 'constants.dart';

part 'snr_data.g.dart';
part 'snr_data.freezed.dart';
@freezed
abstract class SnrData with _$SnrData {

  const factory SnrData({
    required int index,
    required int snrLimit,
    required List<int> snr780,
    required List<int> snr850,
  }) = _SnrData;

  factory SnrData.fromJson(Map<String, dynamic> json) => _$SnrDataFromJson(json);
}

extension SnrDataExtension on SnrData {
  List<int> activeChannel(List<int> snr780, List<int> snr850) {
    return List.generate(48, (i) => i)
        .where((i) => snr780[i] > 30 && snr850[i] > 30)
        .toList();
  }

  bool isPass() {
    List<int> activeChannels = activeChannel(snr780, snr850);
    int r1Pass = r1ChannelIndex.where(activeChannels.contains).length;
    int r2Pass = r2ChannelIndex.where(activeChannels.contains).length;
    return r1Pass > 6 && r2Pass > 6;
  }
}