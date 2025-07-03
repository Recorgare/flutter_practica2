import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:practica2/main.dart';

void main() {
  testWidgets('Login screen displays', (WidgetTester tester) async {
    // Construye la app
    await tester.pumpWidget(MyApp());

    // Verifica que aparezca el texto 'Iniciar Sesión'
    expect(find.text('Iniciar Sesión'), findsOneWidget);

    // Verifica que aparezca el botón 'Ingresar'
    expect(find.text('Ingresar'), findsOneWidget);
  });
}
