import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:task1_todo_list_app/constants/colors.dart';
import 'package:task1_todo_list_app/constants/fontsizes.dart';
import 'package:task1_todo_list_app/constants/fontweights.dart';
import 'package:task1_todo_list_app/constants/strings.dart';
import 'package:task1_todo_list_app/widets/custom_widgets/decorated_text_widget.dart';
import 'package:task1_todo_list_app/widets/custom_widgets/rich_text.dart';
import 'package:task1_todo_list_app/widets/other_widgets/timer.dart';


Future<void> showFullTodoDetails(
  BuildContext context,
  String title,
  String content, 
  String dateTime,
  String isCompleted,
  String datetimeOfCreation
){
  final snackBar = SnackBar(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(20), 
        topLeft: Radius.circular(20)
      )
    ),
    backgroundColor: whiteColorWithOpacity,
    content: Center(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: DecoratedText(
                      text: fullTodoDetails, 
                      color: whiteColor, 
                      fontSize: fontSize5, 
                      fontWeight: fontWeight8
                    )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child: CountDownTimerView(
                    duration: 9,
                    color: blackColor
                  ),
                )
              ],
            ),
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
              content: isCompleted
            ),
            const Gap(10),
            TodoRichText(
              heading: creationDateTimeOfTodo,
              content: datetimeOfCreation
            ),
            const Gap(10),
          ]
        ),
      ),
    ),
    duration: const Duration(seconds: 20),
  );
  return ScaffoldMessenger.of(context).showSnackBar(snackBar)
    .closed;
}