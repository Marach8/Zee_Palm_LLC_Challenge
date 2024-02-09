import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task1_todo_list_app/bloc/app_bloc.dart';
import 'package:task1_todo_list_app/bloc/app_events.dart';
import 'package:task1_todo_list_app/constants/colors.dart';
import 'package:task1_todo_list_app/widgets/other_widgets/bloc_base.dart';


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
          snackBarTheme: const SnackBarThemeData(
            actionTextColor: blackColor,
            actionBackgroundColor: blackColor,
            closeIconColor: blackColor,
          ),
          scrollbarTheme: const ScrollbarThemeData(
            crossAxisMargin: 0,
            thumbColor: MaterialStatePropertyAll(purpleColor),
            mainAxisMargin: 5,
          ),
          bottomSheetTheme: BottomSheetThemeData(
            backgroundColor: whiteColorWithOpacity
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: blackColor,
          ),
          useMaterial3: true,
          brightness: Brightness.light
        ),
        home: const BlocConsumerBase()
      ),
    );
  }
}