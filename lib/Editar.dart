import 'package:flutter/material.dart';
import 'Producto.dart';

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
                editarUsuario();
              },
              child: const Text("Actualizar Datos"),
            ),
            ElevatedButton(
              onPressed: () {
                eliminarUsuario(context);
              },
              child: const Text("Eliminar"),
            )
          ],
        ),
      ),
    );
  }

  void editarUsuario() async {
    String nombre = cntNombre.text;
    int precio = int.parse(cntPrecio.text);
    String descripcion = cntDescripcion.text;

    if (nombre.isEmpty || descripcion.isEmpty || precio == 0) {
      validacion();
    } else {
      //int r             = await Transacciones.edtUsuario(nombre, apellido, fecha, double.parse(peso), id);
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
    int id = idProducto;
    //int r    = await Transacciones.eliUsuario(id);

    Navigator.restorablePushNamedAndRemoveUntil(cnt, '/', (route) => false);
  }

  eliminarUsuario(BuildContext cnt) {
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
      content: const Text("¿Desea continuar con la eliminación de este usuario?"),
      actions: [btnAceptar, btnCancelar],
    );

    showDialog(
        context: cnt,
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
        child: const Text("OK"));

    AlertDialog al = AlertDialog(
      title: const Text("Mensaje"),
      content: const Text("Usuario Actualizado con éxito"),
      actions: [ok],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return al;
        });
  }
}
