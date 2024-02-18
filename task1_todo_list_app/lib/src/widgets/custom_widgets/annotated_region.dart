import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle;
import 'package:task1_todo_list_app/src/constants/colors.dart';

class AnnotatedRegionWidget extends StatelessWidget {
  final String? keyToShow;
  final Widget child;

  const AnnotatedRegionWidget({
    super.key,
    this.keyToShow,
    required this.child
  });

  @override
  Widget build(BuildContext context) {
    final keyIsNull = keyToShow == null;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: keyIsNull ? whiteColor : purpleColor,
        statusBarIconBrightness: keyIsNull ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: keyIsNull ? whiteColor : purpleColor,
        systemNavigationBarIconBrightness: keyIsNull ? Brightness.dark : Brightness.light
      ),
      child: child
    );
  }
}