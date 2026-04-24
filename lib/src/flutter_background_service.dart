

import 'dart:ui';

import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nirsit_plugin/src/utils/logger.dart';

import 'data/nirsit_command.dart';
import 'nirsit/nirsit_service.dart';
import 'nirsit/sdk/nirsit_sdk.dart';


const String methodConnect = 'connect';
const String methodDisconnect = 'disconnect';
const String methodGainCal = 'gainCal';
const String methodChannelRejection = 'channelRejection';
const String methodStopGainCal = 'stopGainCal';
const String methodMeasure = 'measure';
const String methodStop = 'stop';
const String methodVersion = 'version';
const String methodBattery = 'battery';
const String methodSetSnrLimit = 'snrLimit';
const String methodSetOptions = 'options';

const String methodConnectionState = 'connectionState';
const String methodMeasureState = 'measureState';
const String methodData = 'data';

const String methodTest = 'test';

const String keyIp = 'ip';
const String keyPort = 'port';
const String keySnrLimit = 'snr_limit';
const String keyDspOptions = 'dsp_options';
const String keyConnectState = 'connect_state';
const String keyMeasureState = 'measure_state';
const String keyData = 'data';

Future<void> initializeService() async {
  final service = FlutterBackgroundService();

  // iOS용 알림 설정 (필요시)
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'nirsit_foreground', // id
    'Nirsit FOREGROUND SERVICE', // title
    description: 'This channel is used for important notifications.', // description
    importance: Importance.defaultImportance,
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: true,
      isForegroundMode: true,
      notificationChannelId: 'nirsit_foreground',
      initialNotificationTitle: '서비스 실행 중',
      initialNotificationContent: '',
      foregroundServiceNotificationId: 888,
    ),
    iosConfiguration: IosConfiguration(
      autoStart: true,
      onForeground: onStart,
      onBackground: onIosBackground,
    ),
  );
  service.startService();
}

// iOS 백그라운드 진입 시 (보통 false 리턴)
@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  return true;
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  logger.d("onStart");
  DartPluginRegistrant.ensureInitialized();
  if (service is AndroidServiceInstance) {
    final NirsitService nirsit = NirsitService();

    _registerNirsitMethodHandler(service, nirsit);
    _handleNirsitStreamToService(service, nirsit);
  }
  service.on('stopService').listen((event) => service.stopSelf());
}

void _registerNirsitMethodHandler(ServiceInstance service, NirsitService nirsit) {
  service.on(methodTest).listen((event) => nirsit.sendTestCommand());

  service.on(methodConnect).listen((event) async {
    String ip = event?[keyIp] ?? '192.168.0.1';
    int port = event?[keyPort] ?? 50007;
    logger.d("connect $ip : $port");
    final state = await nirsit.connect(ip, port);
    logger.d('plug-in :  connect state = $state');
  });

  service.on(methodGainCal).listen((event) async {
    await nirsit.startGainCal(snrLimit: event?[keySnrLimit] ?? defaultSnrLimit);
  });

  service.on(methodChannelRejection).listen((event) => nirsit.startChannelRejection());

  service.on(methodStopGainCal).listen((event) => nirsit.stopMeasure());

  service.on(methodMeasure).listen((event) => nirsit.startMeasure());

  service.on(methodStop).listen((event) => nirsit.stopMeasure());

  service.on(methodSetSnrLimit).listen((event) {
    nirsit.setSnrLimit(event?[keySnrLimit] ?? defaultSnrLimit);
  });

  service.on(methodSetOptions).listen((event) {
    nirsit.setDSPOptions(event?[keyDspOptions] ?? dspOptionsAll);
  });

  service.on(methodVersion).listen((event) async {
    await nirsit.getVersion(ReceivedDataType.mainVersion);
    await Future.delayed(const Duration(milliseconds: 500));
    await nirsit.getVersion(ReceivedDataType.wifiVersion);
  });

  service.on(methodBattery).listen((event) => nirsit.getBatteryInfo());

  service.on(methodDisconnect).listen((event) => nirsit.disconnect());
}

void _handleNirsitStreamToService(ServiceInstance service, NirsitService nirsit) {
  nirsit.connectionStateStream.listen((state) {
    service.invoke(methodConnectionState, {keyConnectState: state.name});
  });
  nirsit.measureStateStream.listen((state) {
    service.invoke(methodMeasureState, {keyMeasureState: state.name});
  });
  nirsit.dataStream.listen((data) => service.invoke(methodData, {keyData: data.toJson()}));
}