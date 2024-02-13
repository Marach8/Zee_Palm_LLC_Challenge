import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task1_todo_list_app/functions/bloc/app_bloc.dart';
import 'package:task1_todo_list_app/functions/bloc/app_events.dart';
import 'package:task1_todo_list_app/widgets/other_widgets/material_app.dart';


void main() => runApp(const MyApp());


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppBloc>(
      create: (_) => AppBloc()..add(
        const InitializationAppEvent()
      ),
      child: const MaterialAppWidget(),
    );
  }
}