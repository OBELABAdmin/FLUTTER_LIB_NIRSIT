
import 'dart:async';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nirsit_plugin/nirsit_plugin.dart';
import 'package:nirsit_plugin_example/utils/logger.dart';
import 'package:permission_handler/permission_handler.dart';

import 'main_viewmodel.dart';

final providerContainer = ProviderContainer();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await startForegroundService();

  runApp(
      UncontrolledProviderScope(
        container: providerContainer,
        child: const MyApp(),
      )
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> with WidgetsBindingObserver {
  late final MainViewModel _viewModel;
  String connectedWifi = '';



  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _viewModel = ref.read(mainViewModel);
    _viewModel.getConnectedWifiSsid().then((ssid) => setState(() => connectedWifi = ssid ?? ""));
    _viewModel.connectStateStream.listen((event) async {
      String? ssid = await _viewModel.getConnectedWifiSsid();
      setState(() => connectedWifi = ssid ?? "");
      logger.d('connectivity changed $event , ssid = $ssid');
    });
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed: {
        String? ssid = await _viewModel.getConnectedWifiSsid();
        logger.d("resumed ssid = $ssid");
        setState(() => connectedWifi = ssid ?? "");
      }
      break;
      default: {

      }
      break;
    }
  }

  Future<bool> requestLocationPermission() async {
    var status = await Permission.locationWhenInUse.status;
    if (status.isDenied) {
      status = await Permission.locationWhenInUse.request();
    }

    if (status.isPermanentlyDenied) {
      openAppSettings();
      return false;
    }

    return status.isGranted;
  }

  Future<void> _openWifiSetting() async {
    final isGranted = await requestLocationPermission();
    if (isGranted) {
      _viewModel.scanWifi();
      //AppSettings.openAppSettings(type: AppSettingsType.wifi, asAnotherTask: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    var viewModel = ref.watch(mainViewModel);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.3,
            child: _buildWifiList(),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.3,
            child: _buildConnectedDevice(),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.2,
            child: _buildCommandButtonContainer(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openWifiSetting,
        tooltip: 'scan wifi',
        child: const Icon(Icons.wifi),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildWifiList() {
    final wifiList = _viewModel.wifiList;
    return Column(
      children: [
        for(var wifi in wifiList)
          Padding(padding: EdgeInsetsGeometry.symmetric(vertical: 30),
              child: GestureDetector(
                onTap: () => _viewModel.connectWifi(wifi.ssid, wifi.bssid, '12345678'),
                child: Text(
                    wifi.ssid,
                    style: TextStyle(color: Color(0xff000000), fontSize: 20)),
              ))
      ],
    );
  }

  Widget _buildConnectedDevice() {
    return Container(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                '$connectedWifi 연결',
                style: TextStyle(color: Color(0xff000000), fontSize: 20)
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
            Text(
                'nirsit connection : ${_viewModel.isNirsitConnected() ? 'connected' : 'disconnected'}',
                style: TextStyle(color: Color(0xff000000), fontSize: 16)
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
            Text(
                'nirsit state : ${_viewModel.measureStateText}',
                style: TextStyle(color: Color(0xff000000), fontSize: 16)
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
            if (_viewModel.mainVersion.version.isNotEmpty && _viewModel.wifiVersion.version.isNotEmpty)
            Text(
                'version : ${_viewModel.mainVersion.version}, ${_viewModel.wifiVersion.version}',
                style: TextStyle(color: Color(0xff000000), fontSize: 16)
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
            if (_viewModel.batteryInfo.level != 0)
            Text(
                'battery : ${_viewModel.batteryInfo.level}',
                style: TextStyle(color: Color(0xff000000), fontSize: 16)
            ),
          ],
        )
    );
  }

  Widget _buildCommandButtonContainer() {
    return Container(
      padding: EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: _viewModel.connectNirsit,
            child: Text('Connect to Nirsit'),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
          GestureDetector(
            onTap: _viewModel.requestTest,
            child: Text('TEST'),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
          GestureDetector(
            onTap: _viewModel.startGainCal,
            child: Text('GainCal'),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
          GestureDetector(
            onTap: _viewModel.startMeasure,
            child: Text('start Measure'),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
          GestureDetector(
            onTap: _viewModel.stopMeasure,
            child: Text('stop Measure'),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
          GestureDetector(
            onTap: _viewModel.getVersion,
            child: Text('Version'),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
          GestureDetector(
            onTap: _viewModel.requestBatteryInto,
            child: Text('Battery'),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
          GestureDetector(
            onTap: _viewModel.disconnect,
            child: Text('Disconnect'),
          ),
        ],
      ),
    );
  }
}
