import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:task1_todo_list_app/animations/size_animation.dart';
import 'package:task1_todo_list_app/animations/slider_animation.dart';
import 'package:task1_todo_list_app/bloc/app_events.dart';
import 'package:task1_todo_list_app/constants/strings.dart';
import 'package:task1_todo_list_app/bloc/app_bloc.dart';
import 'package:task1_todo_list_app/bloc/app_state.dart';
import 'package:task1_todo_list_app/constants/colors.dart';
import 'package:task1_todo_list_app/widgets/custom_widgets/container_widget.dart';
import 'package:task1_todo_list_app/widgets/custom_widgets/elevatedbutton_widget.dart';
import 'package:task1_todo_list_app/widgets/custom_widgets/leading_back_arrow.dart';
import 'package:task1_todo_list_app/widgets/custom_widgets/lottie_view.dart';
import 'package:task1_todo_list_app/widgets/other_widgets/row_with_profile_picture.dart';
import 'package:task1_todo_list_app/widgets/other_widgets/todo_listview.dart';
import 'dart:developer' as marach show log;



class TodoHomeView extends StatelessWidget {
  const TodoHomeView({super.key});

  @override
  Widget build(BuildContext context){
    final screenWidth = MediaQuery.of(context).size.width;
    final currentState = context.watch<AppBloc>()
      .state as InTodoHomeViewAppState;
    final retrievedTodos = currentState.retrievedTodos;
    marach.log('retrieved in home view is $retrievedTodos');
    final indexToShow = currentState.indexToShow;
    final isZoomed = currentState.isZoomed ?? false;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: indexToShow == null ? whiteColor : purpleColor,
        statusBarIconBrightness: indexToShow == null ?
          Brightness.dark : Brightness.light,
        systemNavigationBarColor: indexToShow == null ?
          whiteColor : purpleColor,
        systemNavigationBarIconBrightness: indexToShow == null ?
          Brightness.dark : Brightness.light,
      ),

      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        floatingActionButton: CustomFAB(
          color: purpleColor,
          function: () => context.read<AppBloc>().add(
            const WantToGoToGetUserDataViewAppEvent()
          ),
        ),
        
        backgroundColor: whiteColorWithOpacity,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Scrollbar(
              interactive: true,
              radius: const Radius.circular(5),                
              thickness: 15,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Gap(20),
                    const Gap(20),
                    LayoutBuilder(
                      builder: (_, constraints) => ContainerWidget(
                        children: [
                          RowWithProfilePicture(isZoomed: isZoomed),
                          SliderAnimationView(
                            numberOfTodos: retrievedTodos.length.toString(),
                            distance: constraints.maxWidth,
                          )
                        ]
                      ),
                    ),
                    const Gap(20),
                      
                    ContainerWidget(
                      padding: const EdgeInsets.all(10),
                      children: retrievedTodos.isEmpty ? [
                        const SizeAnimation(),
                        const Gap(20),
                        const LottieView(lottiePath: lottie2Path)
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