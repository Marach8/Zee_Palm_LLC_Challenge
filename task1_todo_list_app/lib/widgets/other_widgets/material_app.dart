import 'package:flutter/material.dart';
import 'package:task1_todo_list_app/constants/colors.dart';
import 'package:task1_todo_list_app/constants/fontsizes.dart';
import 'package:task1_todo_list_app/constants/fontweights.dart';
import 'package:task1_todo_list_app/constants/strings.dart';
import 'package:task1_todo_list_app/widgets/other_widgets/bloc_base.dart';

class MaterialAppWidget extends StatelessWidget {
  const MaterialAppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        datePickerTheme: const DatePickerThemeData(
          backgroundColor: whiteColor,
          cancelButtonStyle: ButtonStyle(
            foregroundColor: MaterialStatePropertyAll(purpleColor),
            textStyle: MaterialStatePropertyAll(
              TextStyle(
                fontFamily: quickSandFont,
                fontWeight: fontWeight4,
                fontSize: fontSize2
              )
            )
          ),
          confirmButtonStyle: ButtonStyle(
            foregroundColor: MaterialStatePropertyAll(purpleColor),
            textStyle: MaterialStatePropertyAll(
              TextStyle(
                fontFamily: quickSandFont,
                fontWeight: fontWeight4,
                fontSize: fontSize2
              )
            )
          ),
          headerHelpStyle: TextStyle(fontFamily: quickSandFont),
          dividerColor: purpleColor,            
          yearStyle: TextStyle(fontFamily: quickSandFont),
        ),

        timePickerTheme: const TimePickerThemeData(
          backgroundColor: whiteColor,
          cancelButtonStyle: ButtonStyle(
            foregroundColor: MaterialStatePropertyAll(purpleColor),
            textStyle: MaterialStatePropertyAll(
              TextStyle(
                fontFamily: quickSandFont,
                fontWeight: fontWeight4,
                fontSize: fontSize2
              )
            )
          ),
          confirmButtonStyle: ButtonStyle(
            foregroundColor: MaterialStatePropertyAll(purpleColor),
            textStyle: MaterialStatePropertyAll(
              TextStyle(
                fontFamily: quickSandFont,
                fontWeight: fontWeight4,
                fontSize: fontSize2
              )
            )
          ),
          dayPeriodTextStyle: TextStyle(
            fontFamily: quickSandFont,
            fontWeight: fontWeight7,
          ),
          dialHandColor: purpleColor,
          helpTextStyle: TextStyle(fontFamily: quickSandFont),
        ),

        snackBarTheme: const SnackBarThemeData(
          actionTextColor: blackColor,
          actionBackgroundColor: blackColor,
          closeIconColor: blackColor,
        ),

        scrollbarTheme: const ScrollbarThemeData(
          crossAxisMargin: 0,
          thumbColor: MaterialStatePropertyAll(purpleColor),
          mainAxisMargin: 5,
        ),

        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: whiteColorWithOpacity
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor: blackColor,
        ),
        
        useMaterial3: true,
        brightness: Brightness.light
      ),
      home: const BlocConsumerBase()
    );
  }
}