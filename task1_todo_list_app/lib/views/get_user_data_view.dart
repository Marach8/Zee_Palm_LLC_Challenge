import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:task1_todo_list_app/constants/colors.dart';
import 'package:task1_todo_list_app/constants/strings.dart';

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
        backgroundColor: whiteColor,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            onPressed: (){},
          ),
          backgroundColor: whiteColor,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                LottieBuilder.asset(
                  lottie1Path,
                  fit: BoxFit.contain,
                )
              ]
            )
          )
        )
      )
    );
}