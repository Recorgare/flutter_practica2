import 'package:flutter/material.dart';

class ConfigScreen extends StatefulWidget {
  final bool isDarkMode;
  final double fontSize;
  final Color primaryColor;

  ConfigScreen({
    required this.isDarkMode,
    required this.fontSize,
    required this.primaryColor,
  });

  @override
  State<ConfigScreen> createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  late bool isDarkMode;
  late double fontSize;
  late Color primaryColor;

  @override
  void initState() {
    super.initState();
    isDarkMode = widget.isDarkMode;
    fontSize = widget.fontSize;
    primaryColor = widget.primaryColor;
  }

  void _saveAndReturn() {
    Navigator.pop(context, {
      'isDarkMode': isDarkMode,
      'fontSize': fontSize,
      'primaryColor': primaryColor,
    });
  }

  Widget _buildColorButton(Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          primaryColor = color;
        });
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: primaryColor == color ? Colors.black : Colors.transparent,
            width: 2,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        primaryColor: primaryColor,
        textTheme: TextTheme(
          bodyMedium: TextStyle(fontSize: fontSize),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Configuración de Usuario'),
          backgroundColor: Colors.green[900],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              SwitchListTile(
                title: Text('Tema Oscuro'),
                value: isDarkMode,
                onChanged: (value) {
                  setState(() {
                    isDarkMode = value;
                  });
                },
              ),
              SizedBox(height: 20),
              Text('Tamaño de Fuente: ${fontSize.toStringAsFixed(1)}'),
              Slider(
                min: 12,
                max: 30,
                divisions: 18,
                value: fontSize,
                label: fontSize.toStringAsFixed(1),
                onChanged: (value) {
                  setState(() {
                    fontSize = value;
                  });
                },
              ),
              SizedBox(height: 20),
              Text('Color Primario:'),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildColorButton(Colors.blue),
                  _buildColorButton(Colors.red),
                  _buildColorButton(Colors.green),
                  _buildColorButton(Colors.orange),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Seleccionó el color:',
                    style: TextStyle(fontSize: fontSize),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 50,
                    height: 50,
                    color: primaryColor,
                  ),
                ],
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: _saveAndReturn,
                child: Text('Guardar Cambios'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
