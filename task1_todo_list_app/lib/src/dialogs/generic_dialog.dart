import 'package:flutter/material.dart';
import 'package:task1_todo_list_app/src/constants/colors.dart';
import 'package:task1_todo_list_app/src/constants/extensions.dart';
import 'package:task1_todo_list_app/src/constants/fontsizes.dart';
import 'package:task1_todo_list_app/src/constants/fontweights.dart';
import 'package:task1_todo_list_app/src/widgets/custom_widgets/decorated_text_widget.dart';


Future<T?> showGenericDialog<T>({
  required BuildContext context,
  required String title, 
  required String content,
  required Map<String, T?> options
}) => showDialog<T>(
  context: context,
  builder: (_) => AlertDialog(
    title: Center(
      child: Text(title).decorateWithGoogleFont(
        whiteColor,
        fontWeight5, 
        fontSize4, 
      ),
    ),
    content: Center(
      child: DecoratedText(
        text: content,
        color: whiteColor,
        fontSize: fontSize2, 
        fontWeight: fontWeight3
      ),
    ),
    actions: options.keys.map((optionKey){
      final optionValue = options[optionKey];
      return TextButton(
        onPressed: () => optionValue == null ?
          Navigator.pop(context) 
          : Navigator.of(context).pop(optionValue),
        child: Text(optionKey).decorateWithGoogleFont(
          purpleColor, 
          fontWeight7,
          fontSize2, 
        ),        
      );
    }).toList(),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20)
    ),
    scrollable: true,
    backgroundColor: blackColor 
  )
);