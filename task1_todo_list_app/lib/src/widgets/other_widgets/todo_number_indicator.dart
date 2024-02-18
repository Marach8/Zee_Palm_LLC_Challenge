import 'package:flutter/material.dart';
import 'package:task1_todo_list_app/src/constants/colors.dart';
import 'package:task1_todo_list_app/src/constants/extensions.dart';
import 'package:task1_todo_list_app/src/constants/fontsizes.dart';
import 'package:task1_todo_list_app/src/constants/fontweights.dart';
import 'package:task1_todo_list_app/src/widgets/custom_widgets/decorated_text_widget.dart';

class TodosNumberIndicator extends StatelessWidget {
  final String numberOfTodos;
  
  const TodosNumberIndicator({
    super.key,
    required this.numberOfTodos
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        border: const Border().modifyBorder(purpleColor, 0.5),
        borderRadius: BorderRadius.circular(20)
      ),
      child: Center(
        child: DecoratedText(
          text: numberOfTodos, 
          color: purpleColor, 
          fontSize: fontSize2, 
          fontWeight: fontWeight4
        ),
      ),
    );
  }
}