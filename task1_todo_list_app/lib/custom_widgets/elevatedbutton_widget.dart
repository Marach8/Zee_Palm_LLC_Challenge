import 'package:flutter/material.dart';
import 'package:task1_todo_list_app/constants/colors.dart';
import 'package:task1_todo_list_app/constants/fontsizes.dart';
import 'package:task1_todo_list_app/constants/fontweights.dart';
import 'package:task1_todo_list_app/custom_widgets/text_widget.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final double buttonWidth;
  final Color backgroundColor, 
  foregroundColor, borderColor;
  final String text;
  final void Function() function;

  const ElevatedButtonWidget({
    super.key,
    required this.buttonWidth,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.borderColor,
    required this.text,
    required this.function
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      width: buttonWidth,
      child: ElevatedButton(
        onPressed: function, 
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(backgroundColor),
          foregroundColor: MaterialStatePropertyAll(foregroundColor),
          side: MaterialStatePropertyAll(
            BorderSide(
              color: borderColor,
              width: 1,
            )
          ) 
        ),
        child: DecoratedText(
          text: text, 
          color: blackColor, 
          fontSize: fontSize2, 
          fontWeight: fontWeight7
        )
      ),
    );
  }
}