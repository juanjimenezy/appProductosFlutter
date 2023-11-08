import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Producto.dart';

class Registrar extends StatefulWidget {
  const Registrar({super.key});

  @override
  State<Registrar> createState() => _RegistrarState();
}

class _RegistrarState extends State<Registrar> {
  TextEditingController cntNombre = TextEditingController();
  TextEditingController cntPrecio = TextEditingController();
  TextEditingController cntDescripcion = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Producto'),
      ),
      body: FutureBuilder<http.Response>(
        future: regProducto(Producto(
          id: 5,
          nombre: 'PRUEBA4',
          precio: 5000,
          descripcion: 'ESTO ES UNA CUARTA PRUEBA',
        )),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            final response = snapshot.data!;
            return Center(
              child: Text(
                'Status code: ${response.statusCode}\nResponse body: ${response.body}',
              ),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          return Container();
        },
      ),
    );
  }

  Future<http.Response> regProducto(Producto producto) {
    const url = 'http://localhost/MOVILAPI/regProducto.php';
    return http.post(
      Uri.parse(url),
      headers: <String, String>{
        'authorization': 'e1f602bf73cc96f53c10bb7f7953a438fb7b3c0a',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'nombre': producto.nombre,
        'precio': producto.precio,
        'descripcion': producto.descripcion,
      }),
    );
  }
}
