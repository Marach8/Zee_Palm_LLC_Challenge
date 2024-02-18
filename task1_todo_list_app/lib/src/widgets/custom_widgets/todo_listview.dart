import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show ReadContext;
import 'package:task1_todo_list_app/src/functions/bloc/app_bloc.dart';
import 'package:task1_todo_list_app/src/functions/bloc/app_events.dart';
import 'package:task1_todo_list_app/src/constants/colors.dart';
import 'package:task1_todo_list_app/src/constants/extensions.dart';
import 'package:task1_todo_list_app/src/constants/fontsizes.dart';
import 'package:task1_todo_list_app/src/constants/fontweights.dart';
import 'package:task1_todo_list_app/src/constants/maps.dart';
import 'package:task1_todo_list_app/src/constants/strings.dart';
import 'package:task1_todo_list_app/src/dialogs/generic_dialog.dart';
import 'package:task1_todo_list_app/src/models/todo_model.dart';
import 'package:task1_todo_list_app/src/widgets/custom_widgets/decorated_text_widget.dart';
import 'package:task1_todo_list_app/src/widgets/other_widgets/dismissible_background.dart';
import 'package:task1_todo_list_app/src/widgets/other_widgets/list_tile_leading_widget.dart';
import 'package:task1_todo_list_app/src/widgets/other_widgets/list_tile_trailing_widget.dart';

class TodoListView extends StatelessWidget {
  final Iterable<Todo> userTodos;

  const TodoListView({
    super.key,
    required this.userTodos,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Scrollbar(
        interactive: true,
        radius: const Radius.circular(5),
        thickness: 10,
        child: ListView.builder(
          itemCount: userTodos.length,
          itemBuilder: (_, listIndex){

            final eachTodo = userTodos.elementAt(listIndex); 

            final title = eachTodo.todoTitle;
            final content = eachTodo.todoContent;
            final isCompleted = eachTodo.todoIsCompleted;
            final todoKey = eachTodo.todoKey;
        
            return Dismissible(
              key: UniqueKey(),
              confirmDismiss: (_) async {
                //Yet to find a way to have this functionality handled 
                //by the bloc listener. For the moment, it is hardcoded here.
                return showGenericDialog<bool>(
                  context: context, 
                  title: deleteTodo, 
                  content: confirmDeleteTodo, 
                  options: deleteTodoMap
                );
              },
              onDismissed: (direction) {
                if(
                  direction == DismissDirection.endToStart || 
                  direction == DismissDirection.startToEnd
                ){
                  context.read<AppBloc>().add(
                    DeleteTodoAppEvent(keyToDelete: todoKey)
                  );
                }
              },
              background: const BackgroundOfDissmissible(),
              child: Card(
                elevation: 0,
                color: isCompleted
                  ? purpleColor.withOpacity(0.1) 
                  : blackColor.withOpacity(0.05),
                child: ListTile(
                  title: DecoratedText(
                    color: blackColor,
                    fontSize: fontSize2,
                    fontWeight: fontWeight6,
                    text: title,
                    controlOverflow: true,
                  ),
                  subtitle: DecoratedText(
                    color: blackColor,
                    fontSize: fontSize2,
                    fontWeight: fontWeight2,
                    controlOverflow: true,
                    text: content,
                  ),
                  trailing: ListTileTrailingWiget(todoToUpdate: eachTodo,),
                  onLongPress: () => context.read<AppBloc>().add(
                    StartTodoUpdateAppEvent(
                      todoToUpdate: eachTodo
                    )
                  ),
                  onTap: () => context.read<AppBloc>().add(
                    ShowFullTodoDetailsAppEvent(
                      todoKeyToShow: todoKey
                    )
                  ),
                  leading: ListTileLeadingWidget(
                    isCompleted: isCompleted, 
                    listIndex: listIndex
                  ),
                  minLeadingWidth: 0,
                ),
              ),
            );
          }
        ),
      ),
    ).dynamicHeight(userTodos.length);
  }
}