import 'dart:typed_data';

import '../utils/packet_parser.dart';

class RawData {
  final Uint8List startPacket;
  final int dataType;
  final Uint8List length;
  final Uint8List payload;
  final int checksum;

  const RawData({
    required this.startPacket,
    required this.dataType,
    required this.length,
    required this.payload,
    required this.checksum
  });

  @override
  String toString() {
    return 'NirsitData{dataType: $dataType, length: $length, checksum: $checksum}';
  }

  factory RawData.fromBytes(Uint8List data) {
    final startPacket = Uint8List.sublistView(data, 0, 3);
    final lengthList = Uint8List.sublistView(data, 4, headerSize);
    final length = packetParser.getLength(lengthList);
    final payload = packetParser.getPayload(length, data);
    return RawData(
      startPacket: startPacket,
      dataType: data[3],
      length: lengthList,
      payload: payload,
      checksum: data[headerSize + length],
    );
  }
}