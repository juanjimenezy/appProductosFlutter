class Producto {
  final int id;
  final String nombre;
  final int precio;
  final String descripcion;

  Producto({
    required this.id,
    required this.nombre,
    required this.precio,
    required this.descripcion,
  });

  // Crea un método fábrica que convierta un Map de JSON en un objeto Producto
  factory Producto.fromJson(Map<String, dynamic> json) {
    return Producto(
      id: json['PRO_ID'] as int,
      nombre: json['PRO_NOMBRE'] as String,
      precio: json['PRO_PRECIO'] as int,
      descripcion: json['PRO_DESCRIPCION'] as String,
    );
  }
}
