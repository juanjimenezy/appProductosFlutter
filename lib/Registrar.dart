import 'package:flutter/material.dart';

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
              decoration: const InputDecoration(hintText: "Digite el precio"),
            ),
            TextField(
              controller: cntDescripcion,
              decoration: const InputDecoration(hintText: "Digite descripcion"),
            ),
            ElevatedButton(
              onPressed: () {
                registrarUsuario();
              },
              child: const Text("Registrar"),
            )
          ],
        ),
      ),
    );
  }

  void registrarUsuario() async {
    String nombre = cntNombre.text;
    String precio = cntPrecio.text;
    String descripcion = cntDescripcion.text;

    if (nombre.isEmpty || precio.isEmpty || descripcion.isEmpty) {
      validacion();
    } else {
      //int r             = await Transacciones.regUsuario(nombre, apellido, fecha, double.parse(peso));
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
