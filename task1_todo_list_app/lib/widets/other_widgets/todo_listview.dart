import 'package:flutter/material.dart';
import 'package:task1_todo_list_app/constants/colors.dart';
import 'package:task1_todo_list_app/constants/fontsizes.dart';
import 'package:task1_todo_list_app/constants/fontweights.dart';
import 'package:task1_todo_list_app/widets/custom_widgets/decorated_text_widget.dart';

class TodoListView extends StatelessWidget {
  final Iterable<List<String>?> userTodos;

  const TodoListView({
    super.key,
    required this.userTodos
  });

  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: ListView.builder(
        itemCount: userTodos.length,
        itemBuilder: (_, listIndex){
          final eachTodo = userTodos.elementAt(listIndex);
          if(eachTodo == null){
            return const SizedBox.shrink();
          }
      
          final title = eachTodo[0];
          final dueDateTime = eachTodo[1];
          final content = eachTodo[2];
          final isCompleted = eachTodo[3];
          final creationDateTime = eachTodo[4];
      
          return CheckboxListTile.adaptive(
            title: DecoratedText(
              color: blackColor,
              fontSize: fontSize2,
              fontWeight: fontWeight2,
              text: title
            ),
            subtitle: DecoratedText(
              color: blackColor,
              fontSize: fontSize2,
              fontWeight: fontWeight2,
              controlOverflow: true,
              text: content
            ),
            value: true,
            onChanged: (value){},
            tileColor: whiteColor,
          );
        }
      ),
    );
  }
}