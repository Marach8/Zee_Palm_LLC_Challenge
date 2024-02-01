import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task1_todo_list_app/constants/colors.dart';

class GetUserDataView extends StatelessWidget {
  const GetUserDataView({super.key});

  @override
  Widget build(BuildContext context) => 
    AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: whiteColor,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: whiteColor,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.yellow,
      )
    );
}