import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:task1_todo_list_app/bloc/app_bloc.dart';
import 'package:task1_todo_list_app/bloc/app_events.dart';
import 'package:task1_todo_list_app/bloc/app_state.dart';
import 'package:task1_todo_list_app/constants/colors.dart';
import 'package:task1_todo_list_app/constants/extensions.dart';
import 'package:task1_todo_list_app/constants/fontsizes.dart';
import 'package:task1_todo_list_app/constants/fontweights.dart';
import 'package:task1_todo_list_app/constants/strings.dart';
import 'package:task1_todo_list_app/widets/custom_widgets/elevatedbutton_widget.dart';
import 'package:task1_todo_list_app/widets/custom_widgets/stepper_widget.dart';
import 'package:task1_todo_list_app/widets/custom_widgets/decorated_text_widget.dart';
import 'package:task1_todo_list_app/widets/custom_widgets/textfield_widget.dart';

class GetUserDataView extends HookWidget {
  const GetUserDataView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    final currentState = context.watch<AppBloc>().state as InGetUserDataViewAppState;
    final fileNameToDisplay = currentState.fileNameToDisplay;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: whiteColor,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: whiteColor,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: const DecoratedText(
            color: blackColor,
            fontSize: fontSize4,
            fontWeight: fontWeight7,
            text: appName,
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            onPressed: () => context.read<AppBloc>().add(
              const GoToLandingPageAppEvent()
            ),
          ),
          backgroundColor: whiteColor,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AddTodoTextFields(
                    title: enterUsername, 
                    controller: controller
                  ),
                  const Gap(20),
                  GestureDetector(
                    onTap: () => context.read<AppBloc>().add(
                      const AddPhotoAppEvent()
                    ),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        border: const Border().modify(purpleColor, 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: fileNameToDisplay == null ? const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Gap(15),
                          DecoratedText(
                            color: blackColor,
                            fontSize: fontSize3,
                            fontWeight: fontWeight5,
                            text: addPhoto,
                          ),
                          Gap(10),
                          Icon(Icons.photo_camera_outlined),
                          Gap(15),
                        ]
                      ) : Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: DecoratedText(
                          color: blackColor,
                          fontSize: fontSize3,
                          fontWeight: fontWeight5,
                          text: fileNameToDisplay,
                        ),
                      ),
                    ),
                  ),
                  const Gap(20),
          
                  Lottie.asset(
                    lottie1Path,
                    fit: BoxFit.contain,
                  ),
                  const Gap(40),
                  SaveAndSkipButtons(controller: controller)
                ]
              )
            )
          ),
        ),
        bottomSheet: const StepperWidget(
          color1: purpleColor,
          color2: whiteColor
        )
      )
    );
  }
}