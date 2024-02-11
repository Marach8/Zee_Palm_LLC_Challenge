import 'dart:async';

import 'package:flutter/material.dart';
import 'package:task1_todo_list_app/constants/colors.dart';
import 'package:task1_todo_list_app/constants/fontsizes.dart';
import 'package:task1_todo_list_app/constants/fontweights.dart';
import 'package:task1_todo_list_app/constants/strings.dart';
import 'package:task1_todo_list_app/widgets/custom_widgets/decorated_text_widget.dart';

class HomeViewInstructions extends StatefulWidget {
  const HomeViewInstructions({super.key});

  @override
  State<HomeViewInstructions> createState() => _HomeViewInstructionsState();
}

class _HomeViewInstructionsState extends State<HomeViewInstructions> with SingleTickerProviderStateMixin{
  late ScrollController controller;

  @override
  void initState(){
    super.initState();
    controller = ScrollController();
    startAnimation();

    controller.addListener(() {
      if(controller.offset >= controller.position.maxScrollExtent){
        controller.jumpTo(controller.initialScrollOffset);
      }
    });
  }

  void startAnimation(){
    Timer.periodic(const Duration(milliseconds: 100), (_) {
      controller.jumpTo(controller.offset + 1);
    });
  }

  @override 
  void dispose(){
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: SingleChildScrollView(
        controller: controller,
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(emptyString),
            Text(emptyString),
            DecoratedText(
              text: todoOperations, 
              color: blackColor, 
              fontSize: fontSize3, 
              fontWeight: fontWeight3
            ), 
            Text(operation1),
            Text(operation2),
            Text(operation3),
            Text(operation4),
            Text(emptyString),
            Text(emptyString),
          ]
        ),
      ),
    );
  }
}