import 'package:flutter/material.dart';
import 'package:task1_todo_list_app/constants/colors.dart';
import 'package:task1_todo_list_app/constants/extensions.dart';

class ContainerWidget extends StatelessWidget {
  final List<Widget> children;

  const ContainerWidget({
    super.key,
    required this.children
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Container(
      padding: const EdgeInsets.all(10),
      constraints: BoxConstraints(
        maxHeight: screenHeight,
        minHeight: 0,
        minWidth: 0,
        maxWidth: screenWidth
      ),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(20),
        //border: const Border().modify(purpleColor, 0.5)
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: children
      ),
    );
  }
}