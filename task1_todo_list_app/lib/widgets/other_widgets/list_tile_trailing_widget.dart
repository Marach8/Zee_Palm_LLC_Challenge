import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:task1_todo_list_app/functions/bloc/app_bloc.dart';
import 'package:task1_todo_list_app/functions/bloc/app_events.dart';
import 'package:task1_todo_list_app/constants/colors.dart';
import 'package:task1_todo_list_app/constants/fontsizes.dart';
import 'package:task1_todo_list_app/constants/fontweights.dart';
import 'package:task1_todo_list_app/widgets/custom_widgets/decorated_text_widget.dart';


class ListTileTrailingWiget extends StatelessWidget {
  final bool? isCompleted;
  final List<String> todoToUpdate;

  const ListTileTrailingWiget({
    super.key,
    required this.isCompleted,
    required this.todoToUpdate
  });

  @override
  Widget build(BuildContext context) {
    final dueDateTime = todoToUpdate[1];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 50,
          child: DecoratedText(
            text: dueDateTime, 
            color: blackColor.withOpacity(0.5), 
            fontSize: fontSize1, 
            fontWeight: fontWeight5,
            controlOverflow: true,
          ),
        ),
        const Gap(5),
        SizedBox(
          height: 30,
          width: 30,
          child: Checkbox(
            activeColor: purpleColor,
            value: isCompleted, 
            onChanged: (value){
              todoToUpdate.insert(3, value.toString());
              final todoIndex = todoToUpdate.last;
              context.read<AppBloc>().add(
                ConfirmUpdateTodoIsCompletedAppEvent(
                  indexToUpdate: todoIndex,
                  newTodo: todoToUpdate,
                  isCompleted: isCompleted
                )
              );
            },
          ),
        )
      ],
    );
  }
}