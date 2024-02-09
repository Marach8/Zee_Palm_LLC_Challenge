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
import 'package:task1_todo_list_app/widgets/custom_widgets/lottie_view.dart';
import 'package:task1_todo_list_app/widgets/other_widgets/row_with_profile_picture.dart';
import 'package:task1_todo_list_app/widgets/other_widgets/todo_listview.dart';

class TodoHomeView extends StatelessWidget {
  const TodoHomeView({super.key});

  @override
  Widget build(BuildContext context){
    final screenWidth = MediaQuery.of(context).size.width;
    final currentState = context.watch<AppBloc>()
      .state as InTodoHomeViewAppState;
    final retrievedTodos = currentState.retrievedTodos;
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
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            context.read<AppBloc>().add(
              const GoToGetUserDataViewAppEvent()
            );
          },
          backgroundColor: transparentColor,
          foregroundColor: purpleColor,
          mini: true,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
            side: const BorderSide(
              color: purpleColor,
              width: 1,
            )
          ),
          child: const Icon(Icons.arrow_back_rounded),
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
                    ContainerWidget(
                      children: [
                        RowWithProfilePicture(isZoomed: isZoomed),
                        SliderAnimationView(
                          numberOfTodos: retrievedTodos.length.toString()
                        )
                      ]
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