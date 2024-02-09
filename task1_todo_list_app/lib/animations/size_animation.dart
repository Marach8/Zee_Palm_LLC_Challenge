import 'package:flutter/material.dart';
import 'package:task1_todo_list_app/constants/colors.dart';
import 'package:task1_todo_list_app/constants/fontsizes.dart';
import 'package:task1_todo_list_app/constants/fontweights.dart';
import 'package:task1_todo_list_app/constants/strings.dart';
import 'package:task1_todo_list_app/widgets/custom_widgets/decorated_text_widget.dart';


class SizeAnimation extends StatefulWidget {
  const SizeAnimation({
    super.key,
  });

  @override
  State<SizeAnimation> createState() => _SizeAnimationState();
}

class _SizeAnimationState extends State<SizeAnimation> with 
SingleTickerProviderStateMixin{

  late AnimationController sizeController;
  late Animation<double> sizeAnimation;

  @override 
  void initState(){
    super.initState();
    sizeController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
      reverseDuration: const Duration(seconds: 2), 
    )..repeat(reverse: true);

    sizeAnimation = Tween<double> (
      begin: 0.0, end: 5.0
    ).animate(
      CurvedAnimation(
        parent: sizeController,
        curve: Curves.linear
      )
    );

    sizeAnimation.addStatusListener((status) {
      if(status == AnimationStatus.completed){
        sizeController.reverse()
          .then((_) => sizeController.forward());
      }
    });
  }

  @override 
  void dispose(){
    sizeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    sizeController.forward();
    return SizeTransition(
      sizeFactor: sizeAnimation,
      child: ScaleTransition(
        scale: sizeAnimation,
        child: const Center(
          child: DecoratedText(
            color: blackColor,
            fontSize: fontSize2,
            fontWeight: fontWeight3,
            text: noTodos,
          ),
        ),
      )
    );
  }
}