// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  var primaryColor = Colors.pink;
  var accentColor = Colors.amber;

  ThemeMode themeMode = ThemeMode.system;
  String themeText = 's';

  onChange(newColor, n) async {
    n == 1
        ? primaryColor = _toMaterialColor(newColor.hashCode)
        : accentColor = _toMaterialColor(newColor.hashCode);
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('primaryColor', primaryColor.value);
    prefs.setInt('accentColor', accentColor.value);
  }

//change Color to MaterialColor to use in primarySwitch
  MaterialColor _toMaterialColor(colorVal) {
    return MaterialColor(colorVal, <int, Color>{
      50: const Color(0xFFFCE4EC),
      100: const Color(0xFFF8BBD0),
      200: const Color(0xFFF48FB1),
      300: const Color(0xFFF06292),
      400: const Color(0xFFEC407A),
      500: Color(colorVal),
      600: const Color(0xFFD81B60),
      700: const Color(0xFFC2185B),
      800: const Color(0xFFAD1457),
      900: const Color(0xFF880E4F),
    });
  }

  void themeModeChange(newThemeVal) async {
    themeMode = newThemeVal;
    //
    _getThemeText(themeMode);
    notifyListeners();
    //
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('themeText', themeText);
  }

  _getThemeText(ThemeMode tm) {
    if (tm == ThemeMode.dark)
      themeText = 'd';
    else if (tm == ThemeMode.light)
      themeText = 'l';
    else if (tm == ThemeMode.system) themeText = 's';
  }

  getThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    themeText = prefs.getString('themeText') ?? 's';

    if (themeText == 'd')
      themeMode = ThemeMode.dark;
    else if (themeText == 'l')
      themeMode = ThemeMode.light;
    else if (themeText == 's') themeMode = ThemeMode.system;

    notifyListeners();
  }

  getColorMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    primaryColor = _toMaterialColor(prefs.getInt('primaryColor') ?? 0xFFE91E63);
    accentColor = _toMaterialColor(prefs.getInt('accentColor') ?? 0xFFFFC107);

    notifyListeners();
  }
}
