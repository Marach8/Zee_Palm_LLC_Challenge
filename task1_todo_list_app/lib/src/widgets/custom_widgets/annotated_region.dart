import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task1_todo_list_app/src/constants/colors.dart';

class AnnotatedRegionWidget extends StatelessWidget {
  final String? indexToShow;
  final Widget child;

  const AnnotatedRegionWidget({
    super.key,
    this.indexToShow,
    required this.child
  });

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: indexToShow == null ? whiteColor : purpleColor,
        statusBarIconBrightness: indexToShow == null ?
          Brightness.dark : Brightness.light,
        systemNavigationBarColor: indexToShow == null ?
          whiteColor : purpleColor,
        systemNavigationBarIconBrightness: indexToShow == null ?
          Brightness.dark : Brightness.light,
      ),
      child: child
    );
  }
}