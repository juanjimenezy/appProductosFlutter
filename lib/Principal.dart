import 'package:flutter/material.dart';

class Principal extends StatefulWidget {
  const Principal({super.key});

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  List<Map<String, dynamic>> productos = [];

  void getLista() async {
    final infoProductos = [
      {"PRO_ID": 1, "PRO_NOMBRE": "PRUEBA", "PRO_PRECIO": 2000, "PRO_DESCRIPCION": "PRUEBA"}
    ];
    setState(() {
      productos = infoProductos;
    });
  }

  @override // Este metodo se invoca automaticamente cuando se accede a esta clase
  void initState() {
    super.initState();
    getLista();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Listado Usuarios")),
      body: Container(
          margin: const EdgeInsets.fromLTRB(0, 2, 0, 0),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                height: 600,
                child: ListView.builder(
                    itemCount: productos.length,
                    itemBuilder: (context, index) => content(productos[index]["PRO_ID"], productos[index]["PRO_NOMBRE"], productos[index]["PRO_PRECIO"], productos[index]["PRO_DESCRIPCION"])),
              ),
              //*/
            ],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/Registrar");
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget content(int id, String nombre, int precio, String descripcion) {
    return InkWell(
        child: Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "ID: $id",
                            style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 1,
                    ),
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Nombre: $nombre",
                            style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 18),
                          ),
                          Text(
                            "Precio $precio",
                            style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 14),
                          ),
                          Text(
                            "Descripcion $descripcion",
                            style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          // Navigator.pushNamed(context, "/Editar", arguments: {"nombre": nombre, "apellidos": apellido, "fecha": nac, "peso": peso, "id": idusuario});
        });
  }
}
