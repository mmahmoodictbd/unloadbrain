import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget with PreferredSizeWidget {
  const AppBarWidget(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(title),
        leading: Builder(
            builder: (context) => Navigator.canPop(context)
                ? IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                : IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                  )));
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
