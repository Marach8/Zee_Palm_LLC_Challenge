import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task1_todo_list_app/bloc/app_bloc.dart';
import 'package:task1_todo_list_app/bloc/app_state.dart';
import 'package:task1_todo_list_app/constants/colors.dart';
import 'package:task1_todo_list_app/constants/fontsizes.dart';
import 'package:task1_todo_list_app/constants/fontweights.dart';
import 'package:task1_todo_list_app/widets/custom_widgets/decorated_text_widget.dart';

class TodoListView extends StatelessWidget {
  const TodoListView({super.key});

  @override
  Widget build(BuildContext context) {
    final currentState = context.watch<AppBloc>().state as InTodoHomeViewAppState;
    final userTodos = currentState.retrievedTodos;

    return ListView.builder(
      itemCount: userTodos.length,
      itemBuilder: (_, listIndex){
        final eachTodo = userTodos.elementAt(listIndex);
        if(eachTodo == null){
          return const SizedBox.shrink();
        }

        final title = eachTodo[0];
        final dueDateTime = eachTodo[1];
        final content = eachTodo[2];
        final creationDateTime = eachTodo[3];
        final isCompleted = eachTodo[4];

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
    );
  }
}