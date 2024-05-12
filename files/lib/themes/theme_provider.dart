import 'package:flutter/material.dart';
import 'package:macquarie_application/themes/my_themes.dart';

// ChangeNotifier is a Flutter class in the provider package that allows 
// me to update my UI when something changes in my model.
class ThemeProvider extends ChangeNotifier {
  // Private field holding the current theme data.
  ThemeData _themeData = lightMode;  // Initial theme set to light mode.

  // Getter for _themeData to expose it read-only outside the class.
  ThemeData get themeData => _themeData;

  // Setter for _themeData that updates the theme and notifies listeners about the change.
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();  // Notify all the listening widgets to rebuild.
  }

  // Function to toggle the current theme between light and dark.
  void toggleThemes() {
    if (_themeData == lightMode) {
      themeData = darkMode;  // Switch to dark mode if the current theme is light.
    } else {
      themeData = lightMode;  // Switch to light mode if the current theme is dark.
    }
  }
}
