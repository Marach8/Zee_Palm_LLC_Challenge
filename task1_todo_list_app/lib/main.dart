import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task1_todo_list_app/bloc/app_bloc.dart';
import 'package:task1_todo_list_app/bloc/app_events.dart';
import 'package:task1_todo_list_app/bloc/app_state.dart';
import 'package:task1_todo_list_app/constants/colors.dart';
import 'package:task1_todo_list_app/dialogs/material_banner_alert.dart';
import 'package:task1_todo_list_app/dialogs/generic_dialog.dart';
import 'package:task1_todo_list_app/dialogs/loading_screen/loading_screen.dart';
import 'package:task1_todo_list_app/views/add_todo_view.dart';
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
          bottomSheetTheme: BottomSheetThemeData(
            backgroundColor: whiteColorWithOpacity
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: blackColor,
          ),
          useMaterial3: true,
          brightness: Brightness.light
        ),
        home: BlocConsumer<AppBloc, AppState>(
          listener: (context1, appState) async{
            final loadingScreen = LoadingScreen();
            final operation = appState.operation;
            if(appState.isLoading){
              WidgetsBinding.instance.addPostFrameCallback((_) =>
               loadingScreen.showOverlay(
                  context1, operation!
                )
              );
            } 
            else{
              loadingScreen.hideOverlay();
            }

            final error = appState.error;
            if(error != null){
              await showNotification(
                context1, 
                error, 
                Icons.warning_rounded, 
                purpleColor
              );
            }

            final title = appState.alert;
            final content = appState.alertContent;
            if(title != null && content != null){
              //I had to use Future.delayed here because I was avoiding using 
              //BuildContexts across async Gaps.
              await Future.delayed(
                const Duration(seconds: 0)).then((_) async{
                  await showGenericDialog<bool>(
                    context: context1, 
                    title: title, 
                    content: content, 
                    options: {'No': false, 'Yes': true}
                  ).then((result){
                    result != null && result == false ?
                      context1.read<AppBloc>().add(
                        const GoToTodoHomeAppEvent()
                      ) : {};
                  });
                }
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
            else if(appState is InAddTodoViewAppState){
              return const AddTodoView();
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