import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repository/car_repository.dart';
import '../cubit/car_cubit.dart';
import '../cubit/car_state.dart';
import 'add_car_screen.dart';
import './update_cart_screen.dart';
import './delete_car_screen.dart';

class CarListScreen extends StatelessWidget {
  const CarListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Car List'),
      ),
      body: BlocProvider(
        create: (context) => CarCubit(
          carRepository: RepositoryProvider.of<CarRepository>(context),
        )..fetchAllCars(),
        child: const CarListView(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddCarScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CarListView extends StatelessWidget {
  const CarListView({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<CarCubit, CarState>(
      builder: (context, state) {
        if (state is CarLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CarSuccess) {
          final cars = state.cars;
          return ListView.builder(
            itemCount: cars.length,
            itemBuilder: (context, index) {
              final car = cars[index];
              return ListTile(
                title: Text(car.nombre),
                subtitle: Text('Tipo: ${car.tipo}, Potencia: ${car.potencia}, Capacidad: ${car.capacidad}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UpdateCarScreen(car: car),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DeleteCarScreen(car: car),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          );
        } else if (state is CarError) {
          return Center(child: Text('Error: ${state.message}'));
        }
        return const Center(child: Text('Press the button to fetch cars'));
      },
    );
  }
}
