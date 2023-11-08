import 'package:flutter/material.dart';
import 'Principal.dart';
import 'Registrar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "flutter demo",
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      // home: const Inicio(),
      initialRoute: "/",
      routes: {
        "/": (context) => const Principal(),
        "/Registrar": (context) => const Registrar(),
      },
    );
  }
}
