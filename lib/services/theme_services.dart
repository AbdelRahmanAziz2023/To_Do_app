import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';

class ThemeServices {
  final GetStorage box = GetStorage();
  final String key = 'isDarkMode';

  saveThemeToBox(bool isDarkMode) => box.write(key, isDarkMode);
  loadThemeToBox() => box.read<bool>(key)??false;
  ThemeMode get theme=>loadThemeToBox()?ThemeMode.dark:ThemeMode.light;
  void switchTheme(){
    Get.changeThemeMode(loadThemeToBox()?ThemeMode.light:ThemeMode.dark);
    saveThemeToBox(!loadThemeToBox());
  }
}
