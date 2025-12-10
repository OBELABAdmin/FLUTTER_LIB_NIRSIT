
import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'dart:io';

import '../../utils/logger.dart';
import 'nirsit_sdk_bindings.dart';


const int nirsitWindows = 0;
const int nirsitLiteWindows = 1;
const int nirsitAndroid = 2;
const int nirsitLiteAndroid = 3;

const int dspOptionsNone = 0x00;
const int dspOptionsLpf = 0x01;
const int dspOptionsHeartBeat = 0x02;
const int dspOptionsChannelReject = 0x04;
const int dspOptionsMbll = 0x08;
const int dspOptionsResetHemo = 0x10;
const int dspOptionsRso2 = 0x20;

const int dspOptionsDefault = dspOptionsHeartBeat | dspOptionsResetHemo | dspOptionsChannelReject | dspOptionsLpf;
const int dspOptionsAll = dspOptionsDefault | dspOptionsMbll | dspOptionsRso2;

final DynamicLibrary library = () {
  logger.d('load library');
  const String libName = 'NirsitSDK';
  if (Platform.isAndroid || Platform.isLinux) {
    return DynamicLibrary.open('lib$libName.so');
  } else if (Platform.isWindows) {
    return DynamicLibrary.open('$libName.dll');
  } else if (Platform.isIOS) {
    // iOS는 정적 링크되므로 특별한 처리가 필요합니다.
    return DynamicLibrary.executable();
  }
  throw UnsupportedError('Unsupported Platform.');
}();

final NirsitSdkBindings _nirsitSdkBindings = NirsitSdkBindings(library);

class NirsitSdk {
  static final NirsitSdk _instance = NirsitSdk._internals();
  factory NirsitSdk() {
    _instance._initialized();
    return _instance;
  }
  NirsitSdk._internals();

  NirsitSdkBindings get nirsitBindings => _nirsitSdkBindings;
  

  Pointer<Double> _doubleListToPointer(List<double> list) {
    final Pointer<Double> pointer = calloc<Double>(list.length);
    pointer.asTypedList(list.length).setAll(0, list);
    return pointer;
  }

  double test() {
    return nirsitBindings.testDouble();
  }

  void _initialized({int type = nirsitAndroid}) {
    nirsitBindings.initialized(type);
  }

  void calibration(List<double> rawData780, List<double> rawData850) {
    final ptrRawData780 = _doubleListToPointer(rawData780);
    final ptrRawData850 = _doubleListToPointer(rawData850);
    nirsitBindings.calibration(ptrRawData780, ptrRawData850);
    nirsitBindings.addSNRRecentData();
    calloc.free(ptrRawData780);
    calloc.free(ptrRawData850);
  }

  void calibrationRawData(List<double> rawData) {
    final ptrRawData = _doubleListToPointer(rawData);
    nirsitBindings.calibrationRawData(ptrRawData);
    calloc.free(ptrRawData);
  }
  
  void snrCalculation(int snrLimit) {
    nirsitBindings.snrCalculation(snrLimit);
  }

  void setSnrLimit(int snrLimit) {
    nirsitBindings.setSnrLimit(snrLimit);
  }
  
  void setPdGainIndex(List<int> indexList) {
    final ptrIndexList = calloc<Int8>(indexList.length);
    try {
      ptrIndexList.asTypedList(indexList.length).setAll(0, indexList);
      nirsitBindings.setPDGainIndex(ptrIndexList.cast<Char>());
    } finally {
      calloc.free(ptrIndexList);
    }
  }

  void setDSPOption(int option) {
    nirsitBindings.setDSPOption(option);
  }

  Future<(List<double>, List<double>)> measure(List<double> rawData780, List<double> rawData850) async {
    final ptrRawData780 = _doubleListToPointer(rawData780);
    final ptrRawData850 = _doubleListToPointer(rawData850);
    nirsitBindings.measure(ptrRawData780, ptrRawData850);
    final List<double> hbo2List = getHbO2();
    final List<double >hbrList = getHbR();
    calloc.free(ptrRawData780);
    calloc.free(ptrRawData850);
    return (hbo2List, hbrList);
  }

  void measureRawData(List<double> rawData) {
    final ptrRawData = _doubleListToPointer(rawData);
    nirsitBindings.measureRawData(ptrRawData);
    calloc.free(ptrRawData);
  }

  (List<int>, List<int>) getSnr(int snrLimit) {
    snrCalculation(30);
    var snr = nirsitBindings.getGainSNR();
    final List<int> data780 = snr.data_780.asTypedList(snr.length_780).toList();
    final List<int> data850 = snr.data_850.asTypedList(snr.length_850).toList();
    clearRecentData();
    return (data780, data850);
  }

  List<double> getHbO2() {
    var hbo2 = nirsitBindings.getHbO2();
    final hbo2List = hbo2.data.asTypedList(hbo2.length).toList();
    return hbo2List;
  }

  List<double> getHbR() {
    var hbr = nirsitBindings.getHbR();
    var hbrList = hbr.data.asTypedList(hbr.length).toList();
    return hbrList;
  }

  List<int> getRso2() {
    var rso2 = nirsitBindings.getRSO2();
    var rso2List = rso2.data.asTypedList(rso2.length).toList();
    return rso2List;
  }

  void initChannelRejectFlag() => nirsitBindings.initChannelRejectFlag();

  void clearRecentData() => nirsitBindings.clearRecentData();

  void clear() => nirsitBindings.clear();
}