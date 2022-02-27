import 'package:flutter/material.dart';
import 'package:kyahaal/app.dart';
import 'package:kyahaal/utils/startup.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StartupUtils.init();
  runApp(const KyaHaal());
}
