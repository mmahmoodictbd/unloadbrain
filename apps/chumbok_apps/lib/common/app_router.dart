import 'package:flutter/material.dart';

abstract class AppRouter {
  Route<dynamic> generateRoute(String path);
}
