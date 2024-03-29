import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show ReadContext, WatchContext;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:task1_todo_list_app/src/functions/bloc/app_bloc.dart';
import 'package:task1_todo_list_app/src/functions/bloc/app_events.dart';
import 'package:task1_todo_list_app/src/functions/bloc/app_state.dart';
import 'package:task1_todo_list_app/src/constants/colors.dart';
import 'package:task1_todo_list_app/src/constants/extensions.dart';
import 'package:task1_todo_list_app/src/constants/fontsizes.dart';
import 'package:task1_todo_list_app/src/constants/fontweights.dart';
import 'package:task1_todo_list_app/src/constants/strings.dart';
import 'package:task1_todo_list_app/src/widgets/custom_widgets/annotated_region.dart';
import 'package:task1_todo_list_app/src/widgets/custom_widgets/container_widget.dart';
import 'package:task1_todo_list_app/src/widgets/custom_widgets/decorated_text_widget.dart';
import 'package:task1_todo_list_app/src/widgets/custom_widgets/divider_widget.dart';
import 'package:task1_todo_list_app/src/widgets/custom_widgets/elevatedbutton_widget.dart';
import 'package:task1_todo_list_app/src/widgets/custom_widgets/leading_back_arrow.dart';
import 'package:task1_todo_list_app/src/widgets/custom_widgets/lottie_view.dart';
import 'package:task1_todo_list_app/src/widgets/custom_widgets/scrollbar_with_singlechildscrollview.dart';
import 'package:task1_todo_list_app/src/widgets/custom_widgets/textfield_widget.dart';
import 'package:task1_todo_list_app/src/widgets/other_widgets/empty_widget.dart';
import 'package:task1_todo_list_app/src/widgets/other_widgets/todo_number_indicator.dart';


class AddTodoView extends HookWidget {
  const AddTodoView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final currentState = context.watch<AppBloc>().state as InAddTodoViewAppState;
    final isInUpdateMode = currentState.isInUpdateMode ?? false;
    final selectedDateTime = currentState.dueDateTime;
    final oldtitle = currentState.initialTodo?.todoTitle;
    final oldDueDateTime = currentState.initialTodo?.todoDueDateTime;
    final oldContent = currentState.initialTodo?.todoContent;
    final numberOfTodos = currentState.numberOfTodos;

    
    final titleController = useTextEditingController(text: oldtitle);
    final dueDateTimeController = useTextEditingController()
      .chooseText(selectedDateTime, oldDueDateTime);
    final contentController = useTextEditingController(text: oldContent);

    return AnnotatedRegionWidget(      
      child: SafeArea(
        child: Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
          backgroundColor: kIsWeb ? blackColorForWeb : whiteColorWithOpacity,
          appBar: AppBar(
            title: DecoratedText(
              color: blackColor,
              fontSize: fontSize4,
              fontWeight: fontWeight7,
              text: isInUpdateMode ? updateTodo : addTodo,
            ),
            centerTitle: true,
            leading: Padding(
              padding: const EdgeInsets.all(8),
              child: CustomFAB(
                color: blackColor,
                function: () => context.read<AppBloc>().add(
                  const GoToTodoHomeAppEvent()
                ),
              ),
            ),
            backgroundColor: transparentColor,
          ),
          
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: ScrollBarWithSingleChildScrollView(                
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: const LottieView(lottiePath: lottie6Path)
                    ),
                    const Gap(20),

                    ContainerWidget(
                      padding: const EdgeInsets.all(20),
                      children: [
                        numberOfTodos == null || numberOfTodos == 0 ? emptyContainer 
                        : TodosNumberIndicator(
                          numberOfTodos: numberOfTodos.toString()
                        ),
                        const Gap(20),
                        CustomTextField(
                          title: enterTitle, 
                          controller: titleController
                        ),
                        const Gap(10),
                        const DividerWidget(color: purpleColor),
                        const Gap(10),
                        CustomTextField(
                          showSuffixIcon: true,
                          title: enterDueDateTime, 
                          controller: dueDateTimeController,
                          onTap: () async{
                            context.read<AppBloc>().add(
                              GetDateAndTimeAppEvent(context: context)
                            );
                          }
                        ),
                        const Gap(10),
                        const DividerWidget(color: purpleColor),
                        const Gap(10),
                        
                        CustomTextField(
                          title: enterContent, 
                          controller: contentController
                        ),
                        const Gap(10),
                        const DividerWidget(color: purpleColor),
                        const Gap(10),
                      ]
                    )
                  ],
                )
              ),
            ),
          ),
          bottomSheet: Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            width: screenWidth,
            child: ElevatedButtonWidget(
              backgroundColor: blackColor, 
              foregroundColor: whiteColor, 
              borderColor: purpleColor, 
              text: isInUpdateMode ? update : save, 
              function: () {
                context.read<AppBloc>().add(
                  SaveOrUpdateTodoAppEvent(
                    titleController: titleController, 
                    dueDateTimeController: dueDateTimeController, 
                    contentController: contentController
                  )
                );
              }
            ),
          )
        ),
      )
    );
  }
}