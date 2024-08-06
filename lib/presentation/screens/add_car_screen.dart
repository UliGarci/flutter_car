import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/car_cubit.dart';
import '../../data/models/car_model.dart';
import '../cubit/car_state.dart';

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
              BlocConsumer<CarCubit, CarState>(
                listener: (context, state) {
                  if (state is CarSuccess) {
                    Navigator.pop(context);
                  } else if (state is CarError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is CarLoading) {
                    return CircularProgressIndicator();
                  }
                  return ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final newCar = CarModel(
                          nombre: _nombreController.text,
                          tipo: _tipoController.text,
                          potencia: int.parse(_potenciaController.text),
                          capacidad: int.parse(_capacidadController.text),
                        );

                        BlocProvider.of<CarCubit>(context).createCar(newCar);
                      }
                    },
                    child: const Text('Add Car'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}