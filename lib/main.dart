import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/presentation/home_screen.dart';
import 'package:todo/presentation/task_cubit/task_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter todo list using TDD',
      home: Scaffold(
        body: BlocProvider(
          create: (context) => TaskCubit(),
          child: const HomeScreen(),
        ),
      ),
    );
  }
}