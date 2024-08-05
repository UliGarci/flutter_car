import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/repository/car_repository.dart';
import 'presentation/cubit/car_cubit.dart';
import 'presentation/screens/car_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final CarRepository carRepository = CarRepository(apiUrl: 'https://bun0kdtj9i.execute-api.us-east-1.amazonaws.com/Prod');

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: carRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CarCubit(carRepository: carRepository),
          ),
        ],
        child: MaterialApp(
          title: 'Car CRUD App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const CarListScreen(),
        ),
      ),
    );
  }
}