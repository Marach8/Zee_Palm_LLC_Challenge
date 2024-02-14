import 'package:flutter/material.dart';
import 'package:task1_todo_list_app/src/constants/fontsizes.dart';
import 'package:task1_todo_list_app/src/constants/fontweights.dart';
import 'package:task1_todo_list_app/src/widgets/custom_widgets/decorated_text_widget.dart';


class ElevatedButtonWidget extends StatelessWidget {
  final Color backgroundColor, 
  foregroundColor, borderColor;
  final String text;
  final void Function() function;

  const ElevatedButtonWidget({
    super.key,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.borderColor,
    required this.text,
    required this.function
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
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
        color: foregroundColor, 
        fontSize: fontSize2, 
        fontWeight: fontWeight7
      )
    );
  }
}