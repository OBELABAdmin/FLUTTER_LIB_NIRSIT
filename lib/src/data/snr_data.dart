
import 'package:freezed_annotation/freezed_annotation.dart';

import '../nirsit/nirsit_service.dart';
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
  List<int> activeChannel(int snrLimit, List<int> snr780, List<int> snr850) {
    return List.generate(48, (i) => i)
        .where((i) => snr780[i] > snrLimit && snr850[i] > snrLimit)
        .toList();
  }

  bool isPass({int snrLimit = defaultSnrLimit}) {
    List<int> activeChannels = activeChannel(snrLimit, snr780, snr850);
    int r1Pass = r1ChannelIndex.where(activeChannels.contains).length;
    int r2Pass = r2ChannelIndex.where(activeChannels.contains).length;
    return r1Pass > 25 && r2Pass > 6;
  }
}