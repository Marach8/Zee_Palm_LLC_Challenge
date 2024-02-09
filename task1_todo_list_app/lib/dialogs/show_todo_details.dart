import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:task1_todo_list_app/constants/colors.dart';
import 'package:task1_todo_list_app/constants/extensions.dart';
import 'package:task1_todo_list_app/constants/fontsizes.dart';
import 'package:task1_todo_list_app/constants/fontweights.dart';
import 'package:task1_todo_list_app/constants/strings.dart';
import 'package:task1_todo_list_app/widgets/custom_widgets/container_widget.dart';
import 'package:task1_todo_list_app/widgets/custom_widgets/decorated_text_widget.dart';
import 'package:task1_todo_list_app/widgets/custom_widgets/lottie_view.dart';
import 'package:task1_todo_list_app/widgets/custom_widgets/rich_text.dart';
import 'package:task1_todo_list_app/widgets/other_widgets/timer.dart';


Future<void> showFullTodoDetails(
  BuildContext context,
  String title,
  String content, 
  String dateTime,
  String isCompleted,
  String datetimeOfCreation,
  String username
){
  final snackBar = SnackBar(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(20), 
        topLeft: Radius.circular(20)
      )
    ),
    backgroundColor: purpleColorWithOpacity,
    content: ContainerWidget(
      padding: const EdgeInsets.only(left: 5),
      crossAxisAlignment: CrossAxisAlignment.start,
      backgroundColor: transparentColor,
      children: [
        const Gap(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: DecoratedText(
                  text: hey+username+fullTodoDetails, 
                  color: whiteColor, 
                  fontSize: fontSize3, 
                  fontWeight: fontWeight8
                )
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 5.0),
              child: CountDownTimerView(
                duration: 29,
                color: blackColor
              ),
            )
          ],
        ),
        const LottieView(lottiePath: lottie4Path),
        TodoRichText(
          heading: titleOfTodo,
          content: title
        ),
        const Gap(10),
        TodoRichText(
          heading: contentOfTodo,
          content: content
        ),
        const Gap(10),
        TodoRichText(
          heading: dueDateTimeOfTodo,
          content: dateTime
        ),
        const Gap(10),
        TodoRichText(
          heading: isTaskCompleted,
          content: isCompleted.yesOrNo()
        ),
        const Gap(10),
        TodoRichText(
          heading: creationDateTimeOfTodo,
          content: datetimeOfCreation
        ),
        const Gap(10),
      ]
    ),
    duration: const Duration(seconds: 30),
    showCloseIcon: true,
  );
  return ScaffoldMessenger.of(context).showSnackBar(snackBar)
    .closed;
}