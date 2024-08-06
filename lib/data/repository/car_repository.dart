import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import '../models/car_model.dart';

class CarRepository{
  final String apiUrl;

  CarRepository({required this.apiUrl});

  // AGREGAR UN CARRO
  Future<void> createCar(CarModel car) async {
    final response = await http.post(
      Uri.parse('$apiUrl/car'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(car.toJson()..remove('id')),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to create car');
    }
  }

  // ACTUALIZAR CARRO
  Future<void> updateCar(CarModel car) async {
    final response = await http.put(
      Uri.parse('$apiUrl/car/${car.id}'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(car.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update car');
    }
  }

  //ELIMINAR CARRO
  Future<void> deleteCar(String id) async {
    final response = await http.delete(Uri.parse('$apiUrl/car/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete car');
    }
  }

  // OBTENER LISTA DE CARROS
  Future<List<CarModel>> getAllCars() async {
    final response = await http.get(Uri.parse('$apiUrl/car'));
    print(response);
    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      return List<CarModel>.from(l.map((model) => CarModel.fromJson(model)));
    } else {
      throw Exception('Failed to load cars');
    }
  }
}