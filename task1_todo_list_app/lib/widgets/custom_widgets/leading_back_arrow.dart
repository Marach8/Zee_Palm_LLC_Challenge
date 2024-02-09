import 'package:flutter/material.dart';
import 'package:task1_todo_list_app/constants/colors.dart';


class LeadingBackArrowIconButton extends StatelessWidget {
  final void Function()? function;

  const LeadingBackArrowIconButton({
    super.key,
    required this.function
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 20,
      decoration: BoxDecoration(
        border: Border.all(
          width: 5,
          color: blackColor
        )
      ),
      child: IconButton(
        icon: const Icon(Icons.arrow_back_rounded),
        onPressed: function
      ),
    );
  }
}