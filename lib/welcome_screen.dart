import 'package:flutter/material.dart';
import 'preferences_service.dart';
import 'config_screen.dart';
import 'login_screen.dart';
import 'main.dart'; // Para actualizar tema global

class WelcomeScreen extends StatefulWidget {
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String userName = '';
  final PreferencesService _prefs = PreferencesService();

  @override
  void initState() {
    super.initState();
    loadUserName();
  }

  Future<void> loadUserName() async {
    String name = await _prefs.getUserName();
    setState(() {
      userName = name;
    });
  }

  void _logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  // Función para abrir Config y actualizar tema al regresar
  Future<void> _openConfig() async {
    final appState = MyApp.of(context);
    if (appState == null) return;

    // Navega a configuración, pasando estado actual
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ConfigScreen(
          isDarkMode: appState.isDarkMode,
          fontSize: appState.fontSize,
          primaryColor: appState.primaryColor,
        ),
      ),
    );

    if (result != null && result is Map<String, dynamic>) {
      // Actualiza estado global con lo que venga de configuración
      appState.updatePreferences(
        darkMode: result['isDarkMode'],
        font: result['fontSize'],
        color: result['primaryColor'],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio'),
        backgroundColor: Colors.green[900],
        foregroundColor: Colors.white, // texto e íconos blancos
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.green[900], // fondo verde oscuro
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.green[800], // header un poco más claro
                ),
                accountName: Text(
                  userName,
                  style: TextStyle(color: Colors.white),
                ),
                accountEmail: Text(''),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 40, color: Colors.grey),
                ),
              ),
              ListTile(
                leading: Icon(Icons.settings, color: Colors.white),
                title: Text('Configuración',
                    style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  _openConfig();
                },
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app, color: Colors.white),
                title: Text('Cerrar Sesión',
                    style: TextStyle(color: Colors.white)),
                onTap: _logout,
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Text(
          '¡Bienvenido de nuevo al programa, $userName!',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
