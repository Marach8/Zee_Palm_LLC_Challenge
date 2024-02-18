import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show ReadContext, WatchContext;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:task1_todo_list_app/src/animations/size_animation.dart';
import 'package:task1_todo_list_app/src/animations/slider_animation.dart';
import 'package:task1_todo_list_app/src/functions/app_backend.dart';
import 'package:task1_todo_list_app/src/functions/bloc/app_events.dart';
import 'package:task1_todo_list_app/src/constants/strings.dart';
import 'package:task1_todo_list_app/src/functions/bloc/app_bloc.dart';
import 'package:task1_todo_list_app/src/functions/bloc/app_state.dart';
import 'package:task1_todo_list_app/src/constants/colors.dart';
import 'package:task1_todo_list_app/src/widgets/custom_widgets/annotated_region.dart';
import 'package:task1_todo_list_app/src/widgets/custom_widgets/container_widget.dart';
import 'package:task1_todo_list_app/src/widgets/custom_widgets/elevatedbutton_widget.dart';
import 'package:task1_todo_list_app/src/widgets/custom_widgets/leading_back_arrow.dart';
import 'package:task1_todo_list_app/src/widgets/custom_widgets/lottie_view.dart';
import 'package:task1_todo_list_app/src/animations/instructions.dart';
import 'package:task1_todo_list_app/src/widgets/custom_widgets/scrollbar_with_singlechildscrollview.dart';
import 'package:task1_todo_list_app/src/widgets/other_widgets/completed_todo_heading.dart';
import 'package:task1_todo_list_app/src/widgets/other_widgets/empty_widget.dart';
import 'package:task1_todo_list_app/src/widgets/other_widgets/row_with_profile_picture.dart';
import 'package:task1_todo_list_app/src/widgets/custom_widgets/todo_listview.dart';
import 'package:task1_todo_list_app/src/widgets/other_widgets/todo_summary.dart';


class TodoHomeView extends HookWidget {
  const TodoHomeView({super.key});

  @override
  Widget build(BuildContext context){
    final backend = AppBackend();

    final screenWidth = MediaQuery.of(context).size.width;
    final currentState = context.watch<AppBloc>()
      .state as InTodoHomeViewAppState;
    final keyToShow = currentState.todoKeyToShow;
    final isZoomed = currentState.isZoomed ?? false;
    final showCompletedTodos = currentState.showCompletedTodos ?? false;

    final completedTodosFuture = useMemoized(
      () => backend.getCompletedTodos(),
    );

    final completedTodosSnapshot = useFuture(completedTodosFuture);
    final completedTodos = completedTodosSnapshot.data ?? const Iterable.empty();

    final pendingTodosFuture = useMemoized(
      () => backend.getPendingTodos(),
    );
    final pendingTodosSnapshot = useFuture(pendingTodosFuture);
    final pendingTodos = pendingTodosSnapshot.data ?? const Iterable.empty();


    return AnnotatedRegionWidget(
      keyToShow: keyToShow,
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        floatingActionButton: CustomFAB(
          color: purpleColor,
          function: () => context.read<AppBloc>().add(
            const WantToGoToGetUserDataViewAppEvent()
          ),
        ),
        
        backgroundColor: kIsWeb ? blackColorForWeb : whiteColorWithOpacity,
        
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: ScrollBarWithSingleChildScrollView( 
              thickness: 15,             
              child: Column(
                children: [
                  const Gap(20),
                  LayoutBuilder(
                    builder: (_, constraints) => ContainerWidget(
                      children: [
                        RowWithProfilePicture(isZoomed: isZoomed),

                        completedTodos.isNotEmpty && !isZoomed ? TodoSummaryWidget(
                          noOfPendingTodos: pendingTodos.length,
                          noOfCompletedTodos: completedTodos.length,
                        ) : emptySizedBox,

                        SliderAnimationView(
                          numberOfTodos: 
                          ((completedTodos.length) + (pendingTodos.length)).toString(),
                          distance: constraints.maxWidth,
                        )
                      ]
                    ),
                  ),
                  const Gap(20),

                  completedTodos.isNotEmpty && showCompletedTodos ? ContainerWidget(
                    padding: const EdgeInsets.all(10),
                    addBorder: true,
                    children: [
                      const CompletedTodosHeading(),
                      TodoListView(userTodos: completedTodos)
                    ]
                  ) : emptySizedBox,
                  const Gap(20),

                  ContainerWidget(
                    padding: const EdgeInsets.all(10),
                    children: pendingTodos.isEmpty ? [
                      const SizeAnimation(),
                      const Gap(20),
                      const LottieView(lottiePath: lottie2Path)
                    ] : [
                      HomeViewInstructions(
                        todoLength: pendingTodos.length
                      ),
                      TodoListView(userTodos: pendingTodos)
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