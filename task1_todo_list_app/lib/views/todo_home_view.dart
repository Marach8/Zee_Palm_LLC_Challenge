import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:task1_todo_list_app/animations/size_animation.dart';
import 'package:task1_todo_list_app/animations/slider_animation.dart';
import 'package:task1_todo_list_app/bloc/app_events.dart';
import 'package:task1_todo_list_app/constants/strings.dart';
import 'package:task1_todo_list_app/bloc/app_bloc.dart';
import 'package:task1_todo_list_app/bloc/app_state.dart';
import 'package:task1_todo_list_app/constants/colors.dart';
import 'package:task1_todo_list_app/widets/custom_widgets/container_widget.dart';
import 'package:task1_todo_list_app/widets/custom_widgets/elevatedbutton_widget.dart';
import 'package:task1_todo_list_app/widets/other_widgets/row_with_profile_picture.dart';
import 'package:task1_todo_list_app/widets/other_widgets/todo_listview.dart';

class TodoHomeView extends StatelessWidget {
  const TodoHomeView({super.key});

  @override
  Widget build(BuildContext context){
    final screenWidth = MediaQuery.of(context).size.width;
    final currentState = context.watch<AppBloc>().state as InTodoHomeViewAppState;
    final retrievedTodos = currentState.retrievedTodos;
    final indexToShow = currentState.indexToShow;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: indexToShow == null ? whiteColor : purpleColor,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: indexToShow == null ? whiteColor : purpleColor,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),

      child: Scaffold(
        backgroundColor: whiteColorWithOpacity,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ContainerWidget(
                    children: [
                      const RowWithProfilePicture(),
                      SliderAnimationView(
                        numberOfTodos: retrievedTodos.length.toString()
                      )
                    ]
                  ),
                  const Gap(20),
                    
                  ContainerWidget(
                    children: retrievedTodos.isEmpty ? [
                      const SizeAnimation(),
                      const Gap(20),
                      Lottie.asset(lottie2Path)
                    ] : [
                      TodoListView(userTodos: retrievedTodos)
                    ]
                  ),
                  const Gap(50)
                ]
              ),
            ),
          ),
        ),
        bottomSheet: Container(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          width: screenWidth,
          child: ElevatedButtonWidget(
            backgroundColor: purpleColor, 
            foregroundColor: whiteColor, 
            borderColor: blackColor, 
            text: addTodo, 
            function: () => context.read<AppBloc>().add(
              const GoToAddTodoViewAppEvent()
            )
          ),
        ),
      )
    );
  }
}