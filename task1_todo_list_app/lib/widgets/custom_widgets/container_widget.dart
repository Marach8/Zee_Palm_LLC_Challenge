import 'package:flutter/material.dart';
import 'package:task1_todo_list_app/constants/colors.dart';

class ContainerWidget extends StatelessWidget {
  final List<Widget> children;
  final CrossAxisAlignment? crossAxisAlignment;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;

  const ContainerWidget({
    super.key,
    required this.children,
    this.crossAxisAlignment,
    this.backgroundColor,
    this.padding
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