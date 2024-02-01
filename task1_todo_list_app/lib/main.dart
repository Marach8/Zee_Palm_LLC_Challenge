import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task1_todo_list_app/bloc/app_bloc.dart';
import 'package:task1_todo_list_app/bloc/app_state.dart';
import 'package:task1_todo_list_app/views/get_user_data_view.dart';
import 'package:task1_todo_list_app/views/landing_view.dart';

void main() => runApp(const MyApp());


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppBloc>(
      create: (_) => AppBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.black,
          ),
          useMaterial3: true,
          brightness: Brightness.light
        ),
        home: BlocConsumer<AppBloc, AppState>(
          listener: (context1, appState){
      
          },
          // listenWhen: (initialState, newState) 
          //   => initialState != newState,
      
          builder: (context1, appState){
            if (appState is InLandingPageViewAppState){
              return const LandingView();
            }
            else if(appState is InGetUserDataViewAppState){
              return const GetUserDataView();
            }
            //This should never happen
            else {
              return const SizedBox.shrink();
            }
          },
          buildWhen: (initialState, newState) 
            => initialState != newState,
        )
      ),
    );
  }
}