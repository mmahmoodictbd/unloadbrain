import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Notifications"),
      ),
      body: new Container(
        child: new Center(
          child: new Text("Notifications Screen"),
        ),
      ),
    );
  }
}
