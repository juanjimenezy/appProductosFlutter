import 'dart:convert';
import 'package:flutter/material.dart';
import 'Producto.dart';
import 'package:http/http.dart' as http;

class Principal extends StatefulWidget {
  const Principal({super.key});

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  Future<List<Producto>> fetchProductos() async {
    const url = 'http://localhost/MOVILAPI/lisProductos.php';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> productosJson = json.decode(response.body);
      final List<Producto> productos = productosJson.map((productoJson) => Producto.fromJson(productoJson)).toList();
      return productos;
    } else {
      throw Exception('Error al obtener los productos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
      ),
      body: FutureBuilder<List<Producto>>(
        future: fetchProductos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            final productos = snapshot.data!;
            return ListView.builder(
              itemCount: productos.length,
              itemBuilder: (context, index) {
                final producto = productos[index];
                return ListTile(
                  title: Text(producto.nombre),
                  subtitle: Text(producto.descripcion),
                  trailing: Text('\$${producto.precio}'),
                );
              },
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/Registrar");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
