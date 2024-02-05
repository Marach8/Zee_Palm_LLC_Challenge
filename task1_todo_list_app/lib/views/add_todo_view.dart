import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:task1_todo_list_app/bloc/app_bloc.dart';
import 'package:task1_todo_list_app/bloc/app_events.dart';
import 'package:task1_todo_list_app/bloc/app_state.dart';
import 'package:task1_todo_list_app/constants/colors.dart';
import 'package:task1_todo_list_app/constants/fontsizes.dart';
import 'package:task1_todo_list_app/constants/fontweights.dart';
import 'package:task1_todo_list_app/constants/strings.dart';
import 'package:task1_todo_list_app/widets/custom_widgets/container_widget.dart';
import 'package:task1_todo_list_app/widets/custom_widgets/decorated_text_widget.dart';
import 'package:task1_todo_list_app/widets/custom_widgets/divider_widget.dart';
import 'package:task1_todo_list_app/widets/custom_widgets/elevatedbutton_widget.dart';
import 'package:task1_todo_list_app/widets/custom_widgets/textfield_widget.dart';


class AddTodoView extends HookWidget {
  const AddTodoView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final currentState = context.watch<AppBloc>().state as InAddTodoViewAppState;
    final isInUpdateMode = currentState.isInUpdateMode ?? false;
    final oldtitle = currentState.initialTodo?[0];
    final oldDueDateTime = currentState.initialTodo?[1];
    final oldContent = currentState.initialTodo?[2];
    
    final titleController = useTextEditingController(text: oldtitle);
    final dueDateTimeController = useTextEditingController(text: oldDueDateTime);
    final contentController = useTextEditingController(text: oldContent);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: whiteColor,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: whiteColor,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: whiteColorWithOpacity,
          appBar: AppBar(
            title: DecoratedText(
              color: blackColor,
              fontSize: fontSize4,
              fontWeight: fontWeight7,
              text: isInUpdateMode ? updateTodo : addTodo,
            ),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_rounded),
              onPressed: () => context.read<AppBloc>().add(
                const GoToTodoHomeAppEvent()
              ),
            ),
            backgroundColor: transparentColor,
          ),
          
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ContainerWidget(
                      children: [
                        const Gap(10),
                        CustomTextField(
                          title: enterTitle, 
                          controller: titleController
                        ),
                        const Gap(10),
                        const DividerWidget(color: purpleColor),
                        const Gap(10),
        
                        CustomTextField(
                          title: enterDueDateTime, 
                          controller: dueDateTimeController
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
                ),
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