import 'package:flutter/material.dart';
import 'package:task1_todo_list_app/src/constants/extensions.dart';

class DecoratedText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color; 
  final FontWeight fontWeight;
  final bool? controlOverflow;

  const DecoratedText({
    super.key,
    required this.text,
    required this.color,
    required this.fontSize,
    required this.fontWeight,
    this.controlOverflow
  });

  @override
  Widget build(BuildContext context) {
    return Text(text).decorateWithGoogleFont(
      color, 
      fontWeight, 
      fontSize,
      controlOverflow 
    );
  }
}