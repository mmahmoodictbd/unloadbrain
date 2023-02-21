import 'package:chumbok_apps/common/app_router.dart';
import 'package:flutter/material.dart';

abstract class AppDefaultRouter implements AppRouter {
  Scaffold defaultScreen(String path) {
    return Scaffold(
      body: Center(
        child: Text('No route defined for $path'),
      ),
    );
  }
}
