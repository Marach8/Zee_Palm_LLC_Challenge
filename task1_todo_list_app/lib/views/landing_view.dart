import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:task1_todo_list_app/constants/colors.dart';
import 'package:task1_todo_list_app/constants/fontsizes.dart';
import 'package:task1_todo_list_app/constants/fontweights.dart';
import 'package:task1_todo_list_app/constants/strings.dart';
import 'package:task1_todo_list_app/custom_widgets/divider.dart';
import 'package:task1_todo_list_app/custom_widgets/textfield.dart';


class LandingView extends StatelessWidget {
  const  LandingView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: whiteColor,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: whiteColor,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: whiteColor,
        body: Center(
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
                      text: manageTodosText, 
                      color: blackColor, 
                      fontSize: fontSize5, 
                      fontWeight: fontWeight7
                    )
                  ],
                ),
                const Gap(10),

                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: DecoratedText(
                    text: appDescription,
                    color: blackColor,
                    fontSize: fontSize2,
                    fontWeight: fontWeight6,
                  ),
                ),
                const DividerWidget(color: blackColor),
                const Gap(20),

                Lottie.asset(
                  lottie3Path,
                  fit: BoxFit.cover
                ),
                const Gap(20),
                const DividerWidget(color: blackColor),
                const Gap(40),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: (){}, 
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(whiteColor),
                      foregroundColor: MaterialStatePropertyAll(blackColor),
                      side: MaterialStatePropertyAll(
                        BorderSide(
                          color: purpleColor,
                          width: 1,
                        )
                      ) 
                    ),
                    child: const DecoratedText(
                      text: getStarted, 
                      color: blackColor, 
                      fontSize: fontSize2, 
                      fontWeight: fontWeight7
                    )
                  ),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}