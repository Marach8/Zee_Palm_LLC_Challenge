import 'dart:async' show Completer;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task1_todo_list_app/src/functions/bloc/app_bloc.dart';
import 'package:task1_todo_list_app/src/functions/bloc/app_state.dart';
import 'package:task1_todo_list_app/src/constants/colors.dart';
import 'package:task1_todo_list_app/src/constants/extensions.dart';
import 'package:task1_todo_list_app/src/constants/fontsizes.dart';
import 'package:task1_todo_list_app/src/constants/fontweights.dart';
import 'package:task1_todo_list_app/src/constants/strings.dart';
import 'package:task1_todo_list_app/src/widgets/other_widgets/timer.dart';


Future<void> showNotification(
  BuildContext context, 
  String text,
  IconData? icon,
  Color buttonColor,
) async{
  final currentState = context.read<AppBloc>().state;
  final completer = Completer<void>();
  final materialBanner = MaterialBanner(
    content: Center(
      child: Text(
        text,
        maxLines: 4,
      ).decorateWithGoogleFont(
        whiteColor,
        fontWeight5,
        fontSize2,
      ),
    ), 
    actions: [
      TextButton(
        onPressed:(){
          ScaffoldMessenger.of(context)
            .hideCurrentMaterialBanner();
          completer.complete();
        }, 
        child: const Text(okString)
          .decorateWithGoogleFont(
            whiteColor, 
            fontWeight5,
            fontSize3,
          )
      )
    ],

    margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
    dividerColor: purpleColor,
    backgroundColor: blackColor,
    padding: const EdgeInsets.all(10),
    leading: CountDownTimerView(
      duration: currentState is InLandingPageViewAppState ? 5 : 3,
      color: blackColor,
    )
  );
  ScaffoldMessenger.of(context)
    .showMaterialBanner(materialBanner);
  
  await Future.any([
    completer.future,
    Future.delayed(
    Duration(
      seconds: currentState is InLandingPageViewAppState ? 7 : 5
    ), () => ScaffoldMessenger.of(context)
        .hideCurrentMaterialBanner()
    )
  ]);
}