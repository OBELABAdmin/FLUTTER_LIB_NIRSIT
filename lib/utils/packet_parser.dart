

import 'dart:typed_data';

import 'package:nirsit_plugin/data/nirsit_command.dart';
import 'package:nirsit_plugin/data/version_info.dart';

import '../data/battery_info.dart';
import '../data/calibration_data.dart';
import '../data/measure_data.dart';
import '../data/nirsit_data.dart';
import '../data/raw_data.dart';
import 'nirsit_command_utils.dart';

const headerSize = 6;

const ldOffset = 57;
const ldDataSize = 2;
const ldCount = 24;
const ldSize = ldDataSize * ldCount;
const pdDataSize = 2;
const pdCount = 32;
const pdSize = pdDataSize * pdCount;

const channelDataSize = 4;
const channelCount = 204;
const measureSequenceSize = 4;
const measureDataSize = channelDataSize * channelCount;
const batteryInfoSize = 2;
const accSize = 6;
const gyroSize = 6;

final PacketParser packetParser = PacketParser();

class PacketParser {

  bool isPacket(Uint8List data) {
    return data[0] == startPacket[0] && data[1] == startPacket[1] && data[2] == startPacket[2];
  }

  bool isChecksumValid(RawData data) {
    final calcChecksum = calculateChecksum(data);
    return data.checksum == calcChecksum;
  }

  RawData parseDataToRawData(Uint8List data) {
    final RawData nirsitData = RawData.fromBytes(data);
    return nirsitData;
  }

  int getLength(Uint8List length) {
    return convertShortToInt(length);
  }


  Uint8List getPayload(int length, Uint8List data) {
    return Uint8List.sublistView(data, headerSize, headerSize + length);
  }

  VersionInfo parseVersion(RawData data) {
    final version = String.fromCharCodes(data.payload);
    return VersionInfo(version: version);
  }

  BatteryInfo parseBatteryInfo(RawData data) {
    int charge = data.payload[0];
    int percent = data.payload[1];
    return BatteryInfo(status: charge, level: percent);
  }

  CalibrationData parseCalibrationData(Uint8List data) {
    final progress = data[0];
    final ldData = Uint8List.sublistView(data, ldOffset, ldOffset + ldSize);
    final pdData = Uint8List.sublistView(data, ldOffset + ldSize, ldOffset + ldSize + pdSize);
    final List<int> ld780 = [];
    final List<int> ld850 = [];
    final List<int> pdStage1 = [];
    final List<int> pdStage2 = [];
    for (var i = 0; i < ldData.length; i = i + 2) {
      ld780.add(ldData[i]);
      ld850.add(ldData[i + 1]);
    }
    for (var i = 0; i < pdData.length; i = i + 2) {
      pdStage1.add(pdData[i]);
      pdStage2.add(pdData[i + 1]);
    }
    return CalibrationData(
      progress: progress,
      ld780: ld780,
      ld850: ld850,
      pdStage1: pdStage1,
      pdStage2: pdStage2
    );
  }

  MeasureData parseMeasureData(Uint8List data) {
    final seq = parseMeasureSeq(data);
    final measureData = Uint8List.sublistView(data, measureSequenceSize, measureSequenceSize + measureDataSize);
    final List<int> data780List = [];
    final List<int> data850List = [];
    for (var i = 0; i < channelCount; i++) {
      final channelData = Uint8List.sublistView(measureData, i * channelDataSize, (i + 1) * channelDataSize);
      var (data780, data850) = parseChannel(channelData);
      data780List.add(data780);
      data850List.add(data850);
    }
    final batteryIndex = measureSequenceSize + measureDataSize;
    final batteryData = Uint8List.sublistView(data, batteryIndex, batteryIndex + batteryInfoSize);

    final accIndex = batteryIndex + batteryInfoSize;
    final gyroIndex = accIndex + accSize;
    final accData = Uint8List.sublistView(data, accIndex, accIndex + accSize);
    final gyroData = Uint8List.sublistView(data, gyroIndex, gyroIndex + gyroSize);
    final (accX, accY, accZ) = parseMovingSensor(accData);
    final (gyroX, gyroY, gyroZ) = parseMovingSensor(gyroData);

    printBytesToHexString('accData', accData);
    printBytesToHexString('gyroData', accData);
    return MeasureData(
      sequence: seq,
      data780: data780List,
      data850: data850List,
      batteryStatus: batteryData[0],
      battery: batteryData[1],
      accX: accX,
      accY: accY,
      accZ: accZ,
      gyroX: gyroX,
      gyroY: gyroY,
      gyroZ: gyroZ,
    );
  }

  int parseMeasureSeq(Uint8List data) {
    final seqBytes = Uint8List.sublistView(data, 0, measureSequenceSize);
    final byteData = ByteData.view(seqBytes.buffer, seqBytes.offsetInBytes, seqBytes.length);
    return byteData.getUint32(0, Endian.big);
  }

  (int, int) parseChannel(Uint8List data) {
    final data780 = data[0] << 8 | data[1];
    final data850 = data[2] << 8 | data[3];
    return (data780, data850);
  }

  (int, int, int) parseMovingSensor(Uint8List data) {
    final byteData = data.buffer.asByteData(data.offsetInBytes, data.length);

    final x = byteData.getInt16(0, Endian.big);
    final y = byteData.getInt16(2, Endian.big);
    final z = byteData.getInt16(4, Endian.big);
    return (x, y, z);
  }

  int calculateChecksum(RawData data) {
    var sum = 0;
    for (final byte in data.startPacket) {
      sum += byte;
    }
    sum += data.dataType;
    for (final byte in data.length) {
      sum += byte;
    }
    for (final byte in data.payload) {
      sum += byte;
    }
    return sum & 0xFF;
  }

}