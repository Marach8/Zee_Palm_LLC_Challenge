import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task1_todo_list_app/constants/colors.dart';

extension ModifyText on Text{
  Text decorateWithGoogleFont(
    Color color, 
    FontWeight fontWeight,
    double fontSize
  ) => Text(
    data ?? '', 
    style: GoogleFonts.getFont(
      'Quicksand',
      fontSize: fontSize,
      fontWeight: fontWeight
    )
  );
}


extension ModifyBorder on Border{
  Border modify(Color color, double width) => Border(
    bottom: BorderSide(
      color: color,
      width: width
    ),
    top: BorderSide(
      color: color,
      width: width
    ),
    left: BorderSide(
      color: color,
      width: width
    ),
    right: BorderSide(
      color: color,
      width: width
    )
  );
}