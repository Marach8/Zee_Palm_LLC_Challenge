import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task1_todo_list_app/bloc/app_bloc.dart';
import 'package:task1_todo_list_app/bloc/app_events.dart';
import 'package:task1_todo_list_app/bloc/app_state.dart';
import 'package:task1_todo_list_app/constants/colors.dart';
import 'package:task1_todo_list_app/dialogs/alert_widget.dart';
import 'package:task1_todo_list_app/dialogs/loading_screen/loading_screen.dart';
import 'package:task1_todo_list_app/views/get_user_data_view.dart';
import 'package:task1_todo_list_app/views/landing_view.dart';
import 'package:task1_todo_list_app/views/todo_home_view.dart';

void main() => runApp(const MyApp());


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppBloc>(
      create: (_) => AppBloc()..add(
        const InitializationAppEvent()
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: blackColor,
          ),
          useMaterial3: true,
          brightness: Brightness.light
        ),
        home: BlocConsumer<AppBloc, AppState>(
          listener: (context1, appState){
            final loadingScreen = LoadingScreen();
            final operation = appState.operation ?? '';
            if(appState.isLoading){
              loadingScreen.showOverlay(
                context1, operation
              );
            } 
            else{
              loadingScreen.hideOverlay();
            }

            final error = appState.error ?? '';
            if(appState.error != null){
              showNotification(
                context1, 
                error, 
                Icons.warning_rounded, 
                purpleColor
              );
            }
          },
          listenWhen: (initialState, newState) 
            => initialState != newState,
      
          builder: (_, appState){
            if (appState is InLandingPageViewAppState){
              return const LandingView();
            }
            else if(appState is InGetUserDataViewAppState){
              return const GetUserDataView();
            }
            else if(appState is InTodoHomeViewAppState){
              return const TodoHomeView();
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