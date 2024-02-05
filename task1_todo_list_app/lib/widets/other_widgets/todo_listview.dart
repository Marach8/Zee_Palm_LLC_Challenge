import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task1_todo_list_app/bloc/app_bloc.dart';
import 'package:task1_todo_list_app/bloc/app_events.dart';
import 'package:task1_todo_list_app/constants/colors.dart';
import 'package:task1_todo_list_app/constants/extensions.dart';
import 'package:task1_todo_list_app/constants/fontsizes.dart';
import 'package:task1_todo_list_app/constants/fontweights.dart';
import 'package:task1_todo_list_app/widets/custom_widgets/decorated_text_widget.dart';
import 'package:task1_todo_list_app/widets/other_widgets/dismissible_background.dart';

class TodoListView extends StatelessWidget {
  final Iterable<List<String>?> userTodos;

  const TodoListView({
    super.key,
    required this.userTodos
  });

  @override
  Widget build(BuildContext context) {
  final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      height: 300,
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
          final isCompleted = bool.tryParse(eachTodo[3]);
          final creationDateTime = eachTodo[4];
          final todoIndex = eachTodo.last;
      
          return Dismissible(
            key: UniqueKey(),
            // confirmDismiss: (direction){
            //   if(
            //     direction == DismissDirection.endToStart || 
            //     direction == DismissDirection.startToEnd
            //   ){
            //     final shouldDelete = context.read<AppBloc>().add(
            //       const ContinueToDismissAppEvent()
            //     );
            //   }
            //   return null;
            // },
            onDismissed: (direction) {
              if(
                direction == DismissDirection.endToStart || 
                direction == DismissDirection.startToEnd
              ){
                context.read<AppBloc>().add(
                  DeleteTodoAppEvent(indexToDelete: todoIndex)
                );
              }
            },
            background: const BackgroundOfDissmissible(),
            child: Card(
              elevation: 0,
              color: blackColor.withOpacity(0.05),
              child: ListTile(
                // selectedTileColor: purpleColor,
                // activeColor: purpleColor,
                title: DecoratedText(
                  color: blackColor,
                  fontSize: fontSize2,
                  fontWeight: fontWeight6,
                  text: title
                ),
                subtitle: DecoratedText(
                  color: blackColor,
                  fontSize: fontSize2,
                  fontWeight: fontWeight2,
                  controlOverflow: true,
                  text: content
                ),
                onLongPress: (){
                  context.read<AppBloc>().add(
                    StartTodoUpdateAppEvent(
                      indexToUpdate: todoIndex,
                    )
                  );
                },
                // value: isCompleted,
                // onChanged: (value){
                //   final newTodo = [
                //     title, 
                //     dueDateTime,
                //     content,
                //     value.toString(),
                //     creationDateTime,
                //     todoIndex
                //   ];
                //   context.read<AppBloc>().add(
                //     UpdateTodoIsCompletedState(
                //       indexToUpdate: todoIndex,
                //       newTodo: newTodo
                //     )
                //   );
                // },
              ),
            ),
          );
        }
      ),
    ).dynamicHeight(userTodos.length);
  }
}
