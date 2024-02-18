import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show ReadContext;
import 'package:task1_todo_list_app/src/constants/colors.dart';
import 'package:task1_todo_list_app/src/constants/fontsizes.dart';
import 'package:task1_todo_list_app/src/constants/fontweights.dart';
import 'package:task1_todo_list_app/src/constants/strings.dart';
import 'package:task1_todo_list_app/src/functions/bloc/app_bloc.dart';
import 'package:task1_todo_list_app/src/functions/bloc/app_events.dart';
import 'package:task1_todo_list_app/src/widgets/custom_widgets/decorated_text_widget.dart';

class TodoSummaryWidget extends StatelessWidget {
  final int noOfCompletedTodos,
  noOfPendingTodos;

  const TodoSummaryWidget({
    super.key,
    required this.noOfCompletedTodos,
    required this.noOfPendingTodos
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        DecoratedText(
          text: pendingTask+noOfPendingTodos.toString(), 
          color: purpleColor, 
          fontSize: fontSize1, 
          fontWeight: fontWeight5
        ),
        const DecoratedText(
          text: colonString, 
          color: purpleColor, 
          fontSize: fontSize2, 
          fontWeight: fontWeight9
        ),
        TextButton(
          onPressed: () => context.read<AppBloc>().add(
            const ShowCompletedTodosAppEvent()
          ),
          child: DecoratedText(
            color: purpleColor,
            fontSize: fontSize1,
            fontWeight: fontWeight5,
            text: noOfCompletedTodos.toString()+completedTask,
          ),
        )
      ],
    );
  }
}