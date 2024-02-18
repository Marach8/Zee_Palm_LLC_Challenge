import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show ReadContext;
import 'package:task1_todo_list_app/src/functions/bloc/app_bloc.dart';
import 'package:task1_todo_list_app/src/functions/bloc/app_events.dart';
import 'package:task1_todo_list_app/src/constants/colors.dart';
import 'package:task1_todo_list_app/src/constants/fontsizes.dart';
import 'package:task1_todo_list_app/src/constants/fontweights.dart';
import 'package:task1_todo_list_app/src/models/todo_model.dart';
import 'package:task1_todo_list_app/src/widgets/custom_widgets/decorated_text_widget.dart';


class ListTileTrailingWiget extends StatelessWidget {
  final Todo todoToUpdate;

  const ListTileTrailingWiget({
    super.key,
    required this.todoToUpdate
  });

  @override
  Widget build(BuildContext context) {
    final dueDateTime = todoToUpdate.todoDueDateTime;
    final isCompleted = todoToUpdate.todoIsCompleted;
    final todoKey = todoToUpdate.todoKey;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 40,
          child: DecoratedText(
            text: dueDateTime, 
            color: blackColor.withOpacity(0.5), 
            fontSize: fontSize1, 
            fontWeight: fontWeight5,
            controlOverflow: true,
          ),
        ),
        SizedBox(
          height: 30,
          width: 30,
          child: Checkbox(
            activeColor: purpleColor,
            value: isCompleted, 
            onChanged: (value){
              context.read<AppBloc>().add(
                ConfirmToUpdateTodoIsCompletedAppEvent(
                  todoKeyToUpdate: todoKey,
                  isCompleted: value
                )
              );
            },
          ),
        )
      ],
    );
  }
}