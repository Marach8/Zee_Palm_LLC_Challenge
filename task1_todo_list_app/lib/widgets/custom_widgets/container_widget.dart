import 'package:flutter/material.dart';
import 'package:task1_todo_list_app/constants/colors.dart';
import 'package:task1_todo_list_app/constants/extensions.dart';

class ContainerWidget extends StatelessWidget {
  final List<Widget> children;
  final CrossAxisAlignment? crossAxisAlignment;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final bool? addBorder;

  const ContainerWidget({
    super.key,
    required this.children,
    this.crossAxisAlignment,
    this.backgroundColor,
    this.padding,
    this.addBorder
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    
    return ClipRect(
      clipBehavior: Clip.hardEdge,
      child: Container(
        padding: padding,
        constraints: BoxConstraints(
          maxHeight: screenHeight,
          minHeight: 0,
          minWidth: 0,
          maxWidth: screenWidth
        ),
        decoration: BoxDecoration(
          color: backgroundColor ?? whiteColor,
          borderRadius: BorderRadius.circular(20),
          border: addBorder ?? false ? Border.all().modify(purpleColor, 0.5) : null
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: children
          ),
        ),
      ),
    );
  }
}