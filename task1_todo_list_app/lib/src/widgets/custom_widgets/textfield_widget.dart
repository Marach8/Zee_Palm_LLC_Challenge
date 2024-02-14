import 'package:flutter/material.dart';
import 'package:task1_todo_list_app/src/constants/colors.dart';
import 'package:task1_todo_list_app/src/constants/fontsizes.dart';
import 'package:task1_todo_list_app/src/constants/fontweights.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final Function(String)? onChanged;
  final Function()? onTap;

  const CustomTextField({
    required this.title,
    required this.controller,
    this.onChanged,
    this.onTap,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: onTap,
      onChanged: onChanged,
      controller: controller,
      maxLines: null, 
      autocorrect: true, 
      cursorColor: blackColor,              
      cursorWidth: 0.5,
      decoration: InputDecoration(
        labelStyle: TextStyle(
          color: blackColor.withOpacity(0.5),
          fontSize: fontSize2,
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
        fontWeight: fontWeight4,
        decoration: TextDecoration.none
      ), 
    );
  }
}