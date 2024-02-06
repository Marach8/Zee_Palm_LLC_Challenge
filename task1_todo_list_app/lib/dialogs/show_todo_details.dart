import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:task1_todo_list_app/constants/colors.dart';
import 'package:task1_todo_list_app/constants/extensions.dart';
import 'package:task1_todo_list_app/constants/fontsizes.dart';
import 'package:task1_todo_list_app/constants/fontweights.dart';
import 'package:task1_todo_list_app/constants/strings.dart';
import 'package:task1_todo_list_app/widets/custom_widgets/rich_text.dart';


Future<void> showFullTodoDetails(
  BuildContext context,
  String title,
  String content, 
  String dateTime,
  String isCompleted,
  String datetimeOfCreation
){
  // final overlay = Overlay.of(context);
  // if(!overlay.mounted){
  //   return;
  // }
  // final overlayEntry = OverlayEntry(
  //   builder: (_) => Material(
  //     color: blackColor.withAlpha(50),
  //     child: const Center(
  //       child: SizedBox.shrink()
  //     )
  //   )
  // );
  // overlay.insert(overlayEntry);

  final snackBar = SnackBar(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(20), 
        topLeft: Radius.circular(20)
      )
    ),
    backgroundColor: purpleColor,
    content: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: const Text(fullTodoDetails)
                    .decorateWithGoogleFont(
                      whiteColor,
                      fontWeight1,
                      fontSize3, 
                    ),
                ),
              ),
              // const Padding(
              //   padding: EdgeInsets.only(top: 5.0),
              //   child: CountDownTimerView(
              //     duration: 9,
              //     color: whiteColor
              //   ),
              // )
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
    duration: const Duration(seconds: 10),
  );
  return ScaffoldMessenger.of(context).showSnackBar(snackBar)
    .closed;
    //.then((_) => overlayEntry.remove());
}