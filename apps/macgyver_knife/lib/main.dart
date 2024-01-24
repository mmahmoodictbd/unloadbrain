import 'package:flutter/material.dart';
import 'package:macgyver_knife/router.dart';

void main() {
  runApp(MacGyverApp());
}

class MacGyverApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MacGyver Knife',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: Router.generateRoute,
        initialRoute: Router.loginRoute);
  }
}
