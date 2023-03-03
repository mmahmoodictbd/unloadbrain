import 'package:chumbok_apps/common/app_analytics.dart';
import 'package:chumbok_apps/common/app_context.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class NavDrawerWidget extends StatelessWidget {
  static bool isNewRouteSameAsCurrent = false;

  const NavDrawerWidget(this.appLogoPath, this.items);

  final String appLogoPath;
  final List<NavDrawerItem> items;

  @override
  Widget build(BuildContext context) {
    return new Drawer(child: Container(child: ListView(children: _prepareNavDrawerItems(context, items))));
  }

  List<Widget> _prepareNavDrawerItems(BuildContext context, List<NavDrawerItem> items) {
    List<Widget> lst = [];
    lst.add(_navDrawerHeader(context));
    lst.add(SizedBox(height: 15.0));
    items.forEach(
        (drawerItem) => lst.add(_buildNavLinkItem(context, drawerItem.icon, drawerItem.linkText, drawerItem.link)));
    return lst;
  }

  DrawerHeader _navDrawerHeader(BuildContext context) {
    return DrawerHeader(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
      child: Container(
        padding: const EdgeInsets.only(top: 0.0, bottom: 0.0),
        child: OverflowBox(
          minWidth: 0.0,
          minHeight: 0.0,
          maxWidth: double.infinity,
          child: Image.asset(appLogoPath, fit: BoxFit.contain),
        ),
      ),
    );
  }

  ListTile _buildNavLinkItem(BuildContext context, icon, String text, String link) {
    return ListTile(
        leading: Icon(icon),
        title: Text(
          text,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        onTap: () {
          if (link.startsWith("http")) {
            _launchUrl(context, link);
          } else {
            Navigator.of(context).pushIfNotCurrent(context.appContext.appRouter.generateRoute(link));
          }
        },
        horizontalTitleGap: 0);
  }

  Future<void> _launchUrl(BuildContext context, String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
    Provider.of<AppAnalytics>(context, listen: false)
        .logEvent(name: 'NavLinkClicked', parameters: <String, dynamic>{'link': url});
  }
}

class NavDrawerItem {
  final String linkText;
  final String link;
  final IconData icon;

  NavDrawerItem({required this.linkText, required this.link, required this.icon});
}

extension AppNavigatorStateExtension on NavigatorState {
  void pushIfNotCurrent(Route route) {
    var newRoute = route.settings.name;
    if (!isCurrent(newRoute!)) {
      push(route);
    } else {
      pop();
    }
  }

  bool isCurrent(String routeName) {
    bool isCurrent = false;
    popUntil((route) {
      if (route.settings.name == routeName) {
        isCurrent = true;
      }
      return true;
    });
    return isCurrent;
  }
}
