import 'package:flutter/material.dart';
import 'package:task1_todo_list_app/constants/colors.dart';
import 'package:task1_todo_list_app/constants/fontsizes.dart';
import 'package:task1_todo_list_app/constants/fontweights.dart';
import 'package:task1_todo_list_app/constants/strings.dart';
import 'package:task1_todo_list_app/widgets/custom_widgets/decorated_text_widget.dart';

class HomeViewInstructions extends StatelessWidget {
  const HomeViewInstructions({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        DecoratedText(
          text: todoOperations, 
          color: blackColor, 
          fontSize: fontSize3, 
          fontWeight: fontWeight3
        ), 
        Text(operation1),
        Text(operation2),
        Text(operation3),
        Text(operation4)
      ],
    );
  }
}