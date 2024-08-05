class CarModel{
  final String? id;
  final String nombre;
  final String tipo;
  final int potencia;
  final int capacidad;

  CarModel({this.id, required this.nombre,required this.tipo,required this.potencia,required this.capacidad});

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      id: json['id'],
      nombre: json['nombre'],
      tipo: json['tipo'],
      potencia: json['potencia'],
      capacidad: json['capacidad'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'tipo': tipo,
      'potencia': potencia,
      'capacidad': capacidad,
    };
  }
}