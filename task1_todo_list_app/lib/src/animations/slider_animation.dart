import 'package:flutter/material.dart';
import 'package:task1_todo_list_app/src/constants/colors.dart';
import 'package:task1_todo_list_app/src/constants/fontsizes.dart';
import 'package:task1_todo_list_app/src/constants/fontweights.dart';
import 'package:task1_todo_list_app/src/constants/strings.dart';
import 'package:task1_todo_list_app/src/widgets/custom_widgets/decorated_text_widget.dart';

class SliderAnimationView extends StatefulWidget {
  final double distance;
  final String numberOfTodos;

  const SliderAnimationView({
    super.key,
    required this.numberOfTodos,
    required this.distance
  });

  @override
  State<SliderAnimationView> createState() => _SliderAnimationState();
}

class _SliderAnimationState extends State<SliderAnimationView> 
with SingleTickerProviderStateMixin{
  late AnimationController sliderController;
  late Animation<Offset> sliderAnimation;

  @override 
  void initState(){
    super.initState();
    sliderController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15)
    )..repeat();

    sliderAnimation = Tween<Offset> (
      begin: Offset(-widget.distance/100, 0), 
      end: const Offset(5, 0)
    ).animate(sliderController);

    sliderAnimation.addStatusListener((status) {
      if(status == AnimationStatus.completed){
        sliderController..reset()..forward();
      }
    });
  }

  @override 
  void dispose(){
    sliderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    sliderController.forward();
    final noOfTodos = int.tryParse(widget.numberOfTodos);
 
    return SlideTransition(
      position: sliderAnimation,
      textDirection: TextDirection.rtl,
      child: DecoratedText(
          color: blackColor,
          fontSize: fontSize2,
          fontWeight: fontWeight3,
          text: noOfTodos == 1 ? '$noOfTodos $todoAdded' :
            '$noOfTodos $todosAdded'
        ),
    );
  }
}