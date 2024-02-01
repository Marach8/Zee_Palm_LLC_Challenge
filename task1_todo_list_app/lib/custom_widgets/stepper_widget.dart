import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:task1_todo_list_app/constants/colors.dart';

class StepperWidget extends StatelessWidget {
  final bool inStep1;

  const StepperWidget({
    super.key,
    required this.inStep1
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: whiteColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 15, width: 50,
            decoration: BoxDecoration(
              color: purpleColor,
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(10)
              ),
              border: const Border().modify()
            ), 
          ),
          const Gap(2),
          Container(
            height: 15, width: 50,
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: const BorderRadius.horizontal(
                right: Radius.circular(10)
              ),
              border: const Border().modify()
            ), 
          )
        ],
      ),
    );
  }
}


extension ModifyBorder on Border{
  Border modify() => const Border(
    bottom: BorderSide(
      color: blackColor,
      width: 0.5
    ),
    top: BorderSide(
      color: blackColor,
      width: 0.5
    ),
    left: BorderSide(
      color: blackColor,
      width: 0.5
    ),
    right: BorderSide(
      color: blackColor,
      width: 0.5
    )
  );
}