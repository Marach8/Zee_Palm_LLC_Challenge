import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:task1_todo_list_app/bloc/app_bloc.dart';
import 'package:task1_todo_list_app/bloc/app_events.dart';
import 'package:task1_todo_list_app/constants/colors.dart';
import 'package:task1_todo_list_app/constants/fontsizes.dart';
import 'package:task1_todo_list_app/constants/fontweights.dart';
import 'package:task1_todo_list_app/constants/strings.dart';
import 'package:task1_todo_list_app/widets/custom_widgets/decorated_text_widget.dart';

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
        color: blackColor, 
        fontSize: fontSize2, 
        fontWeight: fontWeight7
      )
    );
  }
}




class SaveAndSkipButtons extends StatelessWidget {
  final TextEditingController controller;

  const SaveAndSkipButtons({
    super.key,
    required this.controller
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          flex: 1,
          child: ElevatedButtonWidget(
            backgroundColor: whiteColor, 
            foregroundColor: blackColor, 
            borderColor: purpleColor, 
            text: save, 
            function: () => context.read<AppBloc>().add(
              SaveUserDetailsAndGoToTodoHomeAppEvent(
                username: controller.text
              )
            )
          ),
        ),
        const Gap(10),
        Expanded(
          flex: 1,
          child: ElevatedButtonWidget(
            backgroundColor: whiteColor, 
            foregroundColor: blackColor, 
            borderColor: purpleColor, 
            text: skip, 
            function: () => context.read<AppBloc>().add(
              const SkipUserDetailsAndGoToTodoHomeAppEvent()
            )
          ),
        )
      ]
    );
  }
}