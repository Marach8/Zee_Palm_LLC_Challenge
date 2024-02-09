import 'package:flutter/material.dart';
import 'package:task1_todo_list_app/constants/colors.dart';

class BackgroundOfDissmissible extends StatelessWidget {
  const BackgroundOfDissmissible({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: const EdgeInsets.only(left:10, right: 15),
      height: 30, 
      color: purpleColor, 
      alignment: Alignment.centerLeft,
      child: const Wrap(
        children: [
          Align(
            alignment: Alignment.bottomLeft, 
            child: Icon(
              Icons.delete_rounded, 
              color: blackColor
            )
          ),
          Align(
            alignment: Alignment.centerRight, 
            child: Icon(
              Icons.delete_rounded, 
              color: blackColor
            )
          ),
        ]
      )
    );
  }
}