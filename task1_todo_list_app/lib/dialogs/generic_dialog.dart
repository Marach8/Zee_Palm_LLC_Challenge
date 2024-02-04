import 'package:flutter/material.dart';
import 'package:task1_todo_list_app/constants/colors.dart';
import 'package:task1_todo_list_app/constants/extensions.dart';
import 'package:task1_todo_list_app/constants/fontsizes.dart';
import 'package:task1_todo_list_app/constants/fontweights.dart';
import 'package:task1_todo_list_app/widets/custom_widgets/decorated_text_widget.dart';


Future<T?> showGenericDialog<T>({
  required BuildContext context,
  required String title, 
  required String content,
  required Map<String, T?> options
}) => showDialog<T>(
  context: context,
  builder: (_) => AlertDialog(
    title: Text(title).decorateWithGoogleFont(
      whiteColor,
      fontWeight2, 
      fontSize4, 
    ),
    content: DecoratedText(
      text: content,
      color: whiteColor,
      fontSize: fontSize2, 
      fontWeight: fontWeight3
    ),
    actions: options.keys.map((optionKey){
      final optionValue = options[optionKey];
      return TextButton(
        onPressed: () => optionValue == null ?
          Navigator.pop(context) 
          : Navigator.of(context).pop(optionValue),
        child: Text(optionKey).decorateWithGoogleFont(
          purpleColor, 
          fontWeight5,
          fontSize3, 
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