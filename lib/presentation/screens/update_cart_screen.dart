import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/car_cubit.dart';
import '../../data/models/car_model.dart';

class UpdateCarScreen extends StatelessWidget {
  final CarModel car;

  const UpdateCarScreen({required this.car, super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _nombreController = TextEditingController(text: car.nombre);
    final _tipoController = TextEditingController(text: car.tipo);
    final _potenciaController = TextEditingController(text: car.potencia.toString());
    final _capacidadController = TextEditingController(text: car.capacidad.toString());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Car'),
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
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final updatedCar = CarModel(
                      id: car.id,
                      nombre: _nombreController.text,
                      tipo: _tipoController.text,
                      potencia: int.parse(_potenciaController.text),
                      capacidad: int.parse(_capacidadController.text),
                    );
                    BlocProvider.of<CarCubit>(context).updateCar(updatedCar);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Update Car'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
