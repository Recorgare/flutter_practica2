import 'package:flutter/material.dart';
import 'preferences_service.dart';
import 'welcome_screen.dart';
import 'login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();

  // Para acceder a MyAppState y cambiar tema desde otras pantallas
  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  // Estado global del tema, fuente y color
  bool isDarkMode = false;
  double fontSize = 16.0;
  Color primaryColor = Colors.blue;

  final PreferencesService _prefs = PreferencesService();

  @override
  void initState() {
    super.initState();
    loadPreferences();
  }

  Future<void> loadPreferences() async {
    bool theme = await _prefs.getDarkMode();
    double size = await _prefs.getFontSize();
    Color color = await _prefs.getPrimaryColor();

    setState(() {
      isDarkMode = theme;
      fontSize = size;
      primaryColor = color;
    });
  }

  void updatePreferences({
    required bool darkMode,
    required double font,
    required Color color,
  }) async {
    setState(() {
      isDarkMode = darkMode;
      fontSize = font;
      primaryColor = color;
    });
    // Guarda en SharedPreferences
    await _prefs.setDarkMode(darkMode);
    await _prefs.setFontSize(font);
    await _prefs.setPrimaryColor(color);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        primaryColor: primaryColor,
        textTheme: TextTheme(
          bodyMedium: TextStyle(fontSize: fontSize),
        ),
        appBarTheme: AppBarTheme(backgroundColor: Colors.green[900]),
      ),
      home: LoginScreen(),
    );
  }
}
