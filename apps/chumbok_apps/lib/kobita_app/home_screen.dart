import 'package:chumbok_apps/common/appbar_widget.dart';
import 'package:chumbok_apps/common/navdrawer_widget.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _sendAnalyticsEvent(context);
    return new Scaffold(
        appBar: AppBarWidget("Kobita"),
        drawer: buildNavDrawerWidget(),
        body: Container(
          decoration: BoxDecoration(color: Colors.blue.shade100),
          child: Padding(padding: const EdgeInsets.all(22.0)),
        ));
  }

  NavDrawerWidget buildNavDrawerWidget() {
    return NavDrawerWidget(
        "assets/images/kobitaAppLogo.png",
        [
          NavDrawerItem(linkText: "Link1", link: "Link1", icon: FontAwesomeIcons.discord),
          NavDrawerItem(linkText: "Link2", link: "Link2", icon: FontAwesomeIcons.airbnb),
        ],
        NavDrawerAppInfoItem(
            text: "অ্যাপ ইনফো", appName: "Kobita", appVersion: "1.0.0", appIcon: FontAwesomeIcons.info));
  }

  Future<void> _sendAnalyticsEvent(BuildContext context) async {
    FirebaseAnalytics analytics = Provider.of<FirebaseAnalytics>(context, listen: false);
    analytics.setCurrentScreen(screenName: 'HomeScreen');
    await analytics.logEvent(
      name: 'HomeScreen',
      parameters: {},
    );
  }
}
