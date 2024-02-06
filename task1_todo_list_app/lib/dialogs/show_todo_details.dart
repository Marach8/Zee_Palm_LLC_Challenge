import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:task1_todo_list_app/constants/colors.dart';
import 'package:task1_todo_list_app/constants/extensions.dart';
import 'package:task1_todo_list_app/constants/fontsizes.dart';
import 'package:task1_todo_list_app/constants/fontweights.dart';
import 'package:task1_todo_list_app/widets/custom_widgets/rich_text.dart';


void showFullTodoDetails(
  BuildContext context,
  String title,
  String content, 
  String dateTime,
  String isCompleted,
  String datetimeOfCreation
){
  final overlay = Overlay.of(context);
  if(!overlay.mounted){
    return;
  }
  final overlayEntry = OverlayEntry(
    builder: (_) => Material(
      color: blackColor.withAlpha(50),
      child: const Center(
        child: SizedBox.shrink()
      )
    )
  );
  overlay.insert(overlayEntry);

  final snackBar = SnackBar(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(20), 
        topLeft: Radius.circular(20)
      )
    ),
    backgroundColor: whiteColor,
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
                  child: const Text('Full Todo Details')
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
            heading: 'TITLE OF TODO: ',
            content: title
          ),
          const Gap(10),
          TodoRichText(
            heading: 'CONTENT OF TODO: ',
            content: content
          ),
          const Gap(10),
          TodoRichText(
            heading: 'DUE DATE OR TIME OF TODO: ',
            content: dateTime
          ),
          const Gap(10),
          TodoRichText(
            heading: 'IS TASK COMPLETED: ',
            content: isCompleted
          ),
          const Gap(10),
          TodoRichText(
            heading: 'CREATION DATE AND TIME OF TODO: ',
            content: datetimeOfCreation
          ),
          const Gap(10),
        ]
      ),
    ),
    duration: const Duration(seconds: 10),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar)
    .closed.then((_) => overlayEntry.remove());
}