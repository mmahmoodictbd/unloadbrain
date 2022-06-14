import 'package:bangla_kobita_app/app_router.dart';
import 'package:flutter/material.dart';

class NavDrawer {
  Drawer getNavDrawer(BuildContext context) {
    var headerChild = new DrawerHeader(
      child: Center(
        child: Text("চুম্বক কবিতা",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 40)),
      ),
    );

    var aboutChild = new AboutListTile(
      child: new Text(
        "অ্যাপ ইনফো",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      applicationName: "চুম্বক কবিতা",
      applicationVersion: "v1.0.0",
      applicationIcon: new Icon(Icons.adb),
      icon: new Icon(Icons.info, color: Colors.white),
    );

    var navChildren = [
      headerChild,
      SizedBox(height: 15.0),
      _buildNavItem(context, Icons.home, "হোম", AppRouter.homeRoute),
      _buildNavItem(context, Icons.home, "হোম 2", AppRouter.homeRoute2),
      aboutChild
    ];

    return new Drawer(
        child: Container(
            color: Colors.indigo, child: ListView(children: navChildren)));
  }

  ListTile _buildNavItem(
      BuildContext context, var icon, String s, String routeName) {
    return ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(
          s,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        onTap: () {
          () => Navigator.of(context).pop();
          Navigator.of(context).pushNamed(routeName);
        });
  }
}
