import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/car_cubit.dart';
import '../../data/models/car_model.dart';

class AddCarScreen extends StatelessWidget {
  const AddCarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _nombreController = TextEditingController();
    final _tipoController = TextEditingController();
    final _potenciaController = TextEditingController();
    final _capacidadController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Car'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the car name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _tipoController,
                decoration: const InputDecoration(labelText: 'Tipo'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the car type';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _potenciaController,
                decoration: const InputDecoration(labelText: 'Potencia'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the car power';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _capacidadController,
                decoration: const InputDecoration(labelText: 'Capacidad'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the car capacity';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final newCar = CarModel(
                      nombre: _nombreController.text,
                      tipo: _tipoController.text,
                      potencia: int.parse(_potenciaController.text),
                      capacidad: int.parse(_capacidadController.text),
                    );

                    try {
                      final response = await http.post(
                        Uri.parse(
                            'https://bun0kdtj9i.execute-api.us-east-1.amazonaws.com/Prod/car'),
                        headers: {'Content-Type': 'application/json'},
                        body: jsonEncode(newCar.toJson()..remove('id')),
                      );
                      if (response.statusCode == 200) {
                        Navigator.pop(context);
                      } else {
                        print('Error: ${response.body}');
                      }
                    } catch (e) {
                      print('Error creating car: $e');
                    }
                  }
                },
                child: const Text('Add Car'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
