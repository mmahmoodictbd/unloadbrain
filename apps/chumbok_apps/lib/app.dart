import 'package:chumbok_apps/flavor_config.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chumbok Apps',
      home: Scaffold(
        appBar: AppBar(
          title: Text(FlavorConfig.getFlavorName()),
        ),
      ),
    );
  }
}
