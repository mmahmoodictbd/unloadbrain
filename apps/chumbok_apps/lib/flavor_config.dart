import 'package:flutter/material.dart';

class FlavorConfig {
  final String name;
  final Color color;
  final Map<String, dynamic> dynamicVariables;

  static late FlavorConfig _instance;

  static FlavorConfig get instance {
    return _instance;
  }

  factory FlavorConfig({
    required String name,
    Color color = Colors.red,
    Map<String, dynamic> dynamicVariables = const {},
  }) {
    _instance = FlavorConfig._internal(
      name,
      color,
      dynamicVariables,
    );

    return _instance;
  }

  FlavorConfig._internal(this.name, this.color, this.dynamicVariables);

  static String getFlavorName() => _instance.name;

  static Color getColor() => _instance.color;

  static Map<String, dynamic> getValues() => _instance.dynamicVariables;

  static dynamic getValue(String key) => _instance.dynamicVariables[key];
}
