import 'package:flutter/material.dart';
import 'package:task1_todo_list_app/src/constants/colors.dart';


class CustomFAB extends StatelessWidget {
  final void Function()? function;
  final Color color;

  const CustomFAB({
    super.key,
    required this.function,
    required this.color
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: function,
      backgroundColor: transparentColor,
      foregroundColor: color,
      mini: true,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
        side: BorderSide(
          color: color,
          width: 1,
        )
      ),
      child: const Icon(Icons.arrow_back_rounded),
    );
  }
}