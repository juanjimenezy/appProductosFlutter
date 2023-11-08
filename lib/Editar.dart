// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'Producto.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Editar extends StatefulWidget {
  const Editar({super.key});

  @override
  State<Editar> createState() => _EditarState();
}

class _EditarState extends State<Editar> {
  TextEditingController cntNombre = TextEditingController();
  TextEditingController cntPrecio = TextEditingController();
  TextEditingController cntDescripcion = TextEditingController();
  int idProducto = 0;

  void cargarInfo(Producto producto) {
    setState(() {
      cntNombre.text = producto.nombre;
      cntPrecio.text = producto.precio.toString();
      cntDescripcion.text = producto.descripcion;
      idProducto = producto.id;
    });
  }

  @override
  Widget build(BuildContext context) {
    Producto arg = ModalRoute.of(context)?.settings.arguments as Producto;
    cargarInfo(arg);

    return Scaffold(
      appBar: AppBar(title: const Text("Datos del registro")),
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
                editarProducto();
              },
              child: const Text("Actualizar Datos"),
            ),
            ElevatedButton(
              onPressed: () {
                eliminarProducto(context, idProducto);
              },
              child: const Text("Eliminar"),
            )
          ],
        ),
      ),
    );
  }

  void editarProducto() async {
    String nombre = cntNombre.text;
    int precio = int.parse(cntPrecio.text);
    String descripcion = cntDescripcion.text;

    if (nombre.isEmpty || descripcion.isEmpty || precio == 0) {
      validacion();
    } else {
      editProducto(Producto(id: idProducto, nombre: cntNombre.text, precio: int.parse(cntPrecio.text), descripcion: cntDescripcion.text));
      mostrarAlerta();
    }
  }

  validacion() {
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

  void confirmarEliminar(BuildContext cnt) async {
    Navigator.restorablePushNamedAndRemoveUntil(cnt, '/', (route) => false);
  }

  eliminarProducto(BuildContext cnt, int id) {
    Widget btnAceptar = TextButton(
        onPressed: () {
          confirmarEliminar(cnt);
        },
        child: const Text("Aceptar"));

    //  boton de cancelar
    Widget btnCancelar = TextButton(
        onPressed: () {
          Navigator.pop(cnt);
        },
        child: const Text("Cancelar"));

    AlertDialog al = AlertDialog(
      title: const Text("Alerta"),
      content: const Text("¿Desea continuar con la eliminación de este producto?"),
      actions: [btnAceptar, btnCancelar],
    );

    showDialog(
        context: cnt,
        builder: (BuildContext context) {
          return al;
        });
  }

  Future<http.Response> editProducto(Producto producto) {
    const url = 'http://localhost/MOVILAPI/edtProducto.php';
    return http.post(
      Uri.parse(url),
      headers: <String, String>{
        'authorization': 'e1f602bf73cc96f53c10bb7f7953a438fb7b3c0a',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id': producto.id,
        'nombre': producto.nombre,
        'precio': producto.precio,
        'descripcion': producto.descripcion,
      }),
    );
  }

  mostrarAlerta() {
    Widget ok = TextButton(
        onPressed: () {
          Navigator.pop(context);
          Navigator.restorablePushNamedAndRemoveUntil(context, '/', (route) => false);
        },
        child: const Text("OK"));

    AlertDialog al = AlertDialog(
      title: const Text("Mensaje"),
      content: const Text("Producto Actualizado con éxito"),
      actions: [ok],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return al;
        });
  }
}
