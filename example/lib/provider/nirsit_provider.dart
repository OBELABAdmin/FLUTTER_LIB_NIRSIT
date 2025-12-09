

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nirsit_plugin/data/nirsit_data.dart';
import 'package:nirsit_plugin/nirsit_plugin.dart';

final nirsitProvider = Provider<NirsitPlugin>((ref) {
  final nirsit = NirsitPlugin();
  return nirsit;
});