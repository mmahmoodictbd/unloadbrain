import 'package:chumbok_apps/app.dart';
import 'package:chumbok_apps/common/app_context.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await AppContext.init();
  runApp(App());
}
