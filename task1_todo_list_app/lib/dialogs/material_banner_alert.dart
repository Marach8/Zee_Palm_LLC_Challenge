import 'dart:async';
import 'package:flutter/material.dart';
import 'package:task1_todo_list_app/constants/colors.dart';
import 'package:task1_todo_list_app/constants/extensions.dart';
import 'package:task1_todo_list_app/constants/fontsizes.dart';
import 'package:task1_todo_list_app/constants/fontweights.dart';
import 'package:task1_todo_list_app/widets/other_widgets/timer.dart';


Future<void> showNotification(
  BuildContext context, 
  String text,
  IconData? icon,
  Color buttonColor,
) async{
  final completer = Completer<void>();
  final materialBanner = MaterialBanner(
    content: Text(
      text,
      maxLines: 4,
    ).decorateWithGoogleFont(
      whiteColor,
      fontWeight5,
      fontSize2,
    ), 
    actions: [
      TextButton(
        onPressed:(){
          ScaffoldMessenger.of(context)
            .hideCurrentMaterialBanner();
          completer.complete();
        }, 
        child: const Text('Ok')
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
    leading: const CountDownTimerView(
      duration: 3,
      color: blackColor,
    )
  );
  ScaffoldMessenger.of(context)
    .showMaterialBanner(materialBanner);
  
  await Future.any([
    completer.future,
    Future.delayed(
    const Duration(seconds: 5), () 
      => ScaffoldMessenger.of(context)
        .hideCurrentMaterialBanner()
    )
  ]);
}