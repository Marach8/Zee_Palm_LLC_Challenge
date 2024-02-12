import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:task1_todo_list_app/constants/colors.dart';
import 'package:task1_todo_list_app/constants/extensions.dart';
import 'package:task1_todo_list_app/constants/fontsizes.dart';
import 'package:task1_todo_list_app/constants/fontweights.dart';
import 'package:task1_todo_list_app/constants/strings.dart';
import 'package:task1_todo_list_app/widgets/custom_widgets/decorated_text_widget.dart';

class HomeViewInstructions extends StatefulWidget {
  final int todoLength;

  const HomeViewInstructions({
    super.key,
    required this.todoLength
  });

  @override
  State<HomeViewInstructions> createState() => _HomeViewInstructionsState();
}

class _HomeViewInstructionsState extends State<HomeViewInstructions>{
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: instructions.map(
            (element) {
              if(element.runtimeType != Text){
                return element;
              }
              final textElement = element as Text;
              return textElement.decorateWithGoogleFont(
                blackColor,
                fontWeight3,
                fontSize2
              );
            }
          ).toList()
        ),
      ),
    );
  }
}



const instructions = [
  Text(emptyString),
  Text(emptyString),
  DecoratedText(
    text: todoOperations, 
    color: blackColor, 
    fontSize: fontSize3, 
    fontWeight: fontWeight4
  ), 
  Gap(10),
  Text(operation1),
  Text(operation2),
  Text(operation3),
  Text(operation4),
  Text(emptyString),
  Text(photoViewOperation),
  Text(emptyString),
  Text(emptyString),
];