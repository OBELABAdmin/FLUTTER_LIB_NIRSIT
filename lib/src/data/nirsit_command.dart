
const startPacket = [0x0A, 0x0B, 0x0C];

enum Command {
  startMeasure(value: 0x01),
  gainCal(value: 0x02),
  stopMeasure(value: 0x03),
  mainVersion(value: 0x05),
  wifiVersion(value: 0x06),
  batteryInfo(value: 0x07);

  final int value;
  const Command({required this.value});
}

enum ReceivedDataType {
  measure(value: 0x01),
  gainCal(value: 0x02),
  gainCalCompleted(value: 0x03),
  mainVersion(value: 0x05),
  wifiVersion(value: 0x06),
  batteryInfo(value: 0x07);

  final int value;
  const ReceivedDataType({required this.value});
}