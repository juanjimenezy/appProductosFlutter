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
      appBar: AppBar(title: const Text("Registrar")),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: cntNombre,
              decoration: const InputDecoration(hintText: "Digite Nombre"),
            ),
            TextField(
              controller: cntPrecio,
              decoration: const InputDecoration(hintText: "Digite Precio"),
            ),
            TextField(
              controller: cntDescripcion,
              decoration: const InputDecoration(hintText: "Digite Descripcion"),
            ),
            ElevatedButton(
              onPressed: () {
                String nombre = cntNombre.text;
                int precio = int.parse(cntPrecio.text);
                String descripcion = cntDescripcion.text;
                if (nombre.isEmpty || descripcion.isEmpty) {
                  Validacion();
                } else {
                  regProducto(Producto(id: 0, nombre: nombre, precio: precio, descripcion: descripcion));
                  mostrarAlerta();
                }
              },
              child: const Text("Registrar"),
            )
          ],
        ),
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

  Validacion() {
    Widget ok = TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text("Aceptar"));

    AlertDialog al = AlertDialog(
      title: const Text("Alerta"),
      content: const Text("Por favor, complete todos los datos del fomulario"),
      actions: [ok],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return al;
        });
  }

  mostrarAlerta() {
    Widget ok = TextButton(
        onPressed: () {
          Navigator.pop(context);
          Navigator.restorablePushNamedAndRemoveUntil(context, '/', (route) => false);
        },
        child: const Text("Aceptar"));

    AlertDialog al = AlertDialog(
      title: const Text("Mensaje"),
      content: const Text("Se registró el producto"),
      actions: [ok],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return al;
        });
  }
}
