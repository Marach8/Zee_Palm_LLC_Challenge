import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:task1_todo_list_app/functions/bloc/app_bloc.dart';
import 'package:task1_todo_list_app/functions/bloc/app_events.dart';
import 'package:task1_todo_list_app/constants/colors.dart';
import 'package:task1_todo_list_app/constants/fontsizes.dart';
import 'package:task1_todo_list_app/constants/fontweights.dart';
import 'package:task1_todo_list_app/constants/strings.dart';
import 'package:task1_todo_list_app/widgets/custom_widgets/annotated_region.dart';
import 'package:task1_todo_list_app/widgets/custom_widgets/divider_widget.dart';
import 'package:task1_todo_list_app/widgets/custom_widgets/elevatedbutton_widget.dart';
import 'package:task1_todo_list_app/widgets/custom_widgets/lottie_view.dart';
import 'package:task1_todo_list_app/widgets/custom_widgets/stepper_widget.dart';
import 'package:task1_todo_list_app/widgets/custom_widgets/decorated_text_widget.dart';


class LandingView extends StatelessWidget {
  const  LandingView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return AnnotatedRegionWidget(
      child: Scaffold(
        backgroundColor: whiteColor,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 50),
          child: Scrollbar(
            interactive: true,
            radius: const Radius.circular(5),                
            thickness: 10,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.pen,
                          color: purpleColor
                        ),
                        Gap(10),
                        DecoratedText(
                          text: appName, 
                          color: blackColor, 
                          fontSize: fontSize5, 
                          fontWeight: fontWeight7
                        )
                      ],
                    ),
                    const Gap(10),
                    const LottieView(lottiePath: lottie9Path),
                    const Gap(20),
                    const DecoratedText(
                      text: appDescription,
                      color: blackColor,
                      fontSize: fontSize2,
                      fontWeight: fontWeight6,
                    ),
                    const DividerWidget(color: blackColor),
                    const Gap(20),
                    const LottieView(lottiePath: lottie5Path),
                    const Gap(20),
                    const DividerWidget(color: blackColor),
                    const Gap(40),
                    SizedBox(
                      width: screenWidth,
                      child: ElevatedButtonWidget(
                        backgroundColor: whiteColor,
                        borderColor: purpleColor,
                        foregroundColor: blackColor,
                        text: getStarted,
                        function: () {
                          context.read<AppBloc>().add(
                            const GetUserPermissionAppEvent()
                          );
                        }
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomSheet: const StepperWidget(
          color1: purpleColor,
          color2: whiteColor
        )
      ),
    );
  }
}