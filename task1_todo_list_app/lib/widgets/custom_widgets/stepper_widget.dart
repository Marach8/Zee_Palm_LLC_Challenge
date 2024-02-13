import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:task1_todo_list_app/constants/colors.dart';
import 'package:task1_todo_list_app/constants/extensions.dart';

class StepperWidget extends StatelessWidget {
  final Color color1, color2;

  const StepperWidget({
    super.key,
    required this.color1,
    required this.color2
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 15, width: 50,
          decoration: BoxDecoration(
            color: color1,
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(10)
            ),
            border: const Border().modifyBorder(blackColor, 0.5)
          ), 
        ),
        const Gap(2),
        Container(
          height: 15, width: 50,
          decoration: BoxDecoration(
            color: color2,
            borderRadius: const BorderRadius.horizontal(
              right: Radius.circular(10)
            ),
            border: const Border().modifyBorder(blackColor, 0.5)
          ), 
        )
      ],
    );
  }
}