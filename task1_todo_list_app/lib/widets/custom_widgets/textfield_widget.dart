import 'package:flutter/material.dart';
import 'package:task1_todo_list_app/constants/colors.dart';
import 'package:task1_todo_list_app/constants/fontsizes.dart';
import 'package:task1_todo_list_app/constants/fontweights.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final Function(String)? onChanged;

  const CustomTextField({
    required this.title,
    required this.controller,
    this.onChanged,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return TextField( 
      onChanged: onChanged,
      controller: controller,
      maxLines: null, 
      autocorrect: true, 
      cursorColor: blackColor,              
      cursorWidth: 0.5,
      decoration: InputDecoration(
        labelStyle: const TextStyle(
          color: blackColor,
          fontSize: fontSize3,
          fontWeight: fontWeight3
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: purpleColor
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: blackColor
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        label: Text(title),
      ),
      style: const TextStyle(
        fontSize: fontSize3,
        fontWeight: fontWeight3,
        textBaseline: TextBaseline.ideographic,
        decoration: TextDecoration.none
      ), 
    );
  }
}