import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

extension ModifyText on Text{
  Text decorateWithGoogleFont(
    Color color, 
    FontWeight fontWeight,
    double fontSize,
    [bool? controlOverflow]
  ) => Text(
    data ?? '', 
    style: GoogleFonts.getFont(
      'Quicksand',
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color
    ),
    overflow: controlOverflow ?? false ? TextOverflow.ellipsis : null,
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