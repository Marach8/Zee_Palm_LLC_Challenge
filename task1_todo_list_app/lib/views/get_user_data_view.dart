import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:task1_todo_list_app/functions/bloc/app_bloc.dart';
import 'package:task1_todo_list_app/functions/bloc/app_events.dart';
import 'package:task1_todo_list_app/functions/bloc/app_state.dart';
import 'package:task1_todo_list_app/constants/colors.dart';
import 'package:task1_todo_list_app/constants/extensions.dart';
import 'package:task1_todo_list_app/constants/fontsizes.dart';
import 'package:task1_todo_list_app/constants/fontweights.dart';
import 'package:task1_todo_list_app/constants/strings.dart';
import 'package:task1_todo_list_app/widgets/custom_widgets/annotated_region.dart';
import 'package:task1_todo_list_app/widgets/custom_widgets/divider_widget.dart';
import 'package:task1_todo_list_app/widgets/custom_widgets/elevatedbutton_widget.dart';
import 'package:task1_todo_list_app/widgets/custom_widgets/leading_back_arrow.dart';
import 'package:task1_todo_list_app/widgets/custom_widgets/lottie_view.dart';
import 'package:task1_todo_list_app/widgets/custom_widgets/stepper_widget.dart';
import 'package:task1_todo_list_app/widgets/custom_widgets/decorated_text_widget.dart';
import 'package:task1_todo_list_app/widgets/custom_widgets/textfield_widget.dart';


class GetUserDataView extends HookWidget {
  const GetUserDataView({super.key});

  @override
  Widget build(BuildContext context) {
    final currentState = context.watch<AppBloc>().state as InGetUserDataViewAppState;
    final username = currentState.username;
    final fileNameToDisplay = currentState.fileNameToDisplay;
    final inEditUserDetailsMode = currentState.inEditUserDetailsMode ?? false;
    final controller = useTextEditingController(text: username);

    return AnnotatedRegionWidget(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: const DecoratedText(
            color: blackColor,
            fontSize: fontSize4,
            fontWeight: fontWeight7,
            text: appName,
          ),
          centerTitle: true,
          leading: inEditUserDetailsMode ? const SizedBox.shrink() 
          : Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomFAB(
                color: blackColor,
                function: () => context.read<AppBloc>().add(
                  const GoToLandingPageAppEvent()
                ),
              ),
          ),
          backgroundColor: whiteColorWithOpacity,
        ),

        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Scrollbar(
              interactive: true,
              radius: const Radius.circular(5),                
              thickness: 10,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    inEditUserDetailsMode ? const DecoratedText(
                      color: blackColor,
                      fontSize: fontSize3,
                      fontWeight: fontWeight6,
                      text: updateUserDetails,
                    ) : const SizedBox.shrink(),
                    const Gap(10),
                    const DividerWidget(color: purpleColor),
                    const Gap(20),
                    CustomTextField(
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
                          border: const Border().modifyBorder(purpleColor, 1),
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
                        
                    const LottieView(lottiePath: lottie1Path),
                    const Gap(40),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          flex: 1,
                          child: ElevatedButtonWidget(
                            backgroundColor: whiteColor, 
                            foregroundColor: blackColor, 
                            borderColor: purpleColor, 
                            text: inEditUserDetailsMode ? update : finish,
                            function: () => context.read<AppBloc>().add(
                              SaveUserDataAppEvent(username: controller.text)
                            ),
                          ),
                        ),
                        const Gap(10),
                        inEditUserDetailsMode ? const SizedBox.shrink() : Expanded(
                          flex: 1,
                          child: ElevatedButtonWidget(
                            backgroundColor: whiteColor, 
                            foregroundColor: blackColor, 
                            borderColor: purpleColor, 
                            text: skip, 
                            function: () => context.read<AppBloc>().add(
                              SkipUserDataAppEvent(username: controller.text)
                            )
                          ),
                        )
                      ]
                    ),

                    const Gap(20),
                    const DividerWidget(color: purpleColor),
                  ]
                )
              ),
            )
          ),
        ),
        bottomSheet: const StepperWidget(
          color1: purpleColor,
          color2: purpleColor
        )
      )
    );
  }
}