import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

extension Modify on Text{
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