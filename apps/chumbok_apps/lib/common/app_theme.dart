import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_theme/json_theme.dart';

class AppTheme {
  final String _themePath;
  late final ThemeData theme;

  AppTheme(this._themePath);

  Future<AppTheme> init() async {
    var themeStr = await rootBundle.loadString(_themePath);
    var themeJson = jsonDecode(themeStr);
    theme = ThemeDecoder.decodeThemeData(themeJson)!;
    return this;
  }

  ThemeData get themeData => theme;
}
