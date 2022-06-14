import 'package:flutter/material.dart';
import 'package:bangla_kobita_app/app_router.dart';

void main() {
  runApp(KobitaApp());
}

class KobitaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'চুম্বক কবিতা',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: AppRouter.generateRoute,
        initialRoute: AppRouter.homeRoute2);
  }
}
