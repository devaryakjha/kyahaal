import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';

class StartupUtils {
  static Future<void> init({Iterable<Future>? futures}) async {
    futures ??= <Future>[];
    await Future.wait([
      ...futures,
      Firebase.initializeApp(),
      Hive.initFlutter(),
    ]);
  }
}
