import 'package:flutter/material.dart';
import 'package:macgyver_knife/router.dart';

import 'helper/gridview_builder.dart';

class HomeScreen extends StatefulWidget {
  final String title;

  HomeScreen({Key key, this.title}) : super(key: key);

  @override
  HomeScreenState createState() => new HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final GridViewBuilder gridViewBuilder = new GridViewBuilder();

  Drawer getNavDrawer(BuildContext context) {
    var headerChild = new DrawerHeader(
      child: Image.asset("assets/img/chumbok_logo.png", fit: BoxFit.contain),
    );

    var headerChild1 = new DrawerHeader(
      child: Container(
        padding: const EdgeInsets.only(top: 20.0, bottom: 30.0),
        child: new OverflowBox(
          minWidth: 0.0,
          minHeight: 0.0,
          maxWidth: double.infinity,
          child:
              Image.asset("assets/img/chumbok_logo.png", fit: BoxFit.contain),
        ),
      ),
    );

    var aboutChild = new AboutListTile(
      child: new Text("About"),
      applicationName: "MacGyver Knife",
      applicationVersion: "v1.0.0",
      applicationIcon: new Icon(Icons.adb),
      icon: new Icon(Icons.info),
    );

    var navChildren = [
      headerChild,
      SizedBox(height: 15.0),
      _buildNavItem(Icons.home, "Home", Router.homeRoute),
      _buildNavItem(Icons.settings, "Settings", Router.settingsRoute),
      _buildNavItem(Icons.power_settings_new, "Logout", Router.logoutRoute),
      aboutChild
    ];

    return new Drawer(child: new ListView(children: navChildren));
  }

  ListTile _buildNavItem(var icon, String s, String routeName) {
    return new ListTile(
      leading: new Icon(icon),
      title: new Text(s),
      onTap: () {
        setState(() {
          Navigator.of(context).pop();
          Navigator.of(context).pushNamed(routeName);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("MacGyver Knife"),
      ),
      body: gridViewBuilder.build(),
      drawer: getNavDrawer(context),
    );
  }
}
