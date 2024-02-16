import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:task1_todo_list_app/src/functions/bloc/app_bloc.dart';
import 'package:task1_todo_list_app/src/functions/bloc/app_events.dart';
import 'package:task1_todo_list_app/src/models/todo_model.dart';
import 'package:task1_todo_list_app/src/models/user_details_model.dart';
import 'package:task1_todo_list_app/src/widgets/other_widgets/material_app.dart';


void main() async {
  await Hive.initFlutter().then((_){
    Hive.registerAdapter(UserDetailsAdapter());
    Hive.registerAdapter(TodoAdapter());
  });
  runApp(const MyApp());
}


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