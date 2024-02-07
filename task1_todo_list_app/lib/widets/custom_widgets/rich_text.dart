import 'package:flutter/material.dart';
import 'package:task1_todo_list_app/constants/colors.dart';
import 'package:task1_todo_list_app/constants/extensions.dart';
import 'package:task1_todo_list_app/constants/fontsizes.dart';
import 'package:task1_todo_list_app/constants/fontweights.dart';


class TodoRichText extends StatelessWidget {
  final String heading, content;

  const TodoRichText({
    required this.heading, 
    required this.content, 
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),                            
      decoration: BoxDecoration(
        color: purpleColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow:  const [
          BoxShadow(
            blurRadius: 5, 
            spreadRadius: 1, 
            color: whiteColor
          )
        ]
      ),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(text: heading)
              .decorateTextSpan(
                whiteColor,
                fontSize2, 
                fontWeight3
              ),
            TextSpan(text: content)
              .decorateTextSpan(
                whiteColor, 
                fontSize2, 
                fontWeight7
              ),
          ]
        )
      )
    );
  }
}