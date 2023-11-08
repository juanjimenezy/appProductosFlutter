import 'package:app_2023_10_17/Editar.dart';
import 'package:flutter/material.dart';
import 'Principal.dart';
import 'Registrar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "App Productos",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.amber),
      initialRoute: "/",
      routes: {
        "/": (context) => const Principal(),
        "/Registrar": (context) => const Registrar(),
        "/Editar": (context) => const Editar(),
      },
    );
  }
}
