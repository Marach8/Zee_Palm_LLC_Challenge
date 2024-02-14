import 'package:flutter/material.dart';
import 'package:task1_todo_list_app/src/constants/colors.dart';
import 'package:task1_todo_list_app/src/constants/fontsizes.dart';
import 'package:task1_todo_list_app/src/constants/fontweights.dart';
import 'package:task1_todo_list_app/src/widgets/custom_widgets/decorated_text_widget.dart';

class ListTileLeadingWidget extends StatelessWidget {
  final bool? isCompleted;
  final int listIndex;

  const ListTileLeadingWidget({
    super.key,
    required this.isCompleted,
    required this.listIndex
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        height: 15,
        width: 15,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isCompleted ?? false ? purpleColor: blackColor,
            width: 0.5,
          )
        ),
        child: Center(
          child: DecoratedText(
            color: isCompleted ?? false ? purpleColor: blackColor,
            fontSize: fontSize1,
            fontWeight: fontWeight9,
            text: (listIndex + 1).toString(),
          ),
        ),
      ),
    );
  }
}