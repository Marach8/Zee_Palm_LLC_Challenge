import 'package:flutter/material.dart';
import 'package:task1_todo_list_app/constants/colors.dart';
import 'package:task1_todo_list_app/constants/fontsizes.dart';
import 'package:task1_todo_list_app/constants/fontweights.dart';
import 'package:task1_todo_list_app/constants/strings.dart';
import 'package:task1_todo_list_app/widets/custom_widgets/decorated_text_widget.dart';

class SliderAnimationView extends StatefulWidget {
  final String numberOfTodos;

  const SliderAnimationView({
    super.key,
    required this.numberOfTodos
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
      duration: const Duration(seconds: 10)
    )..repeat();

    sliderAnimation = Tween<Offset> (
      begin: const Offset(0, 0), 
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
    final screenWidth = MediaQuery.of(context).size.width;
 
    return Transform(
      //alignment: Alignment.centerLeft,
      transform: Matrix4.identity()
        ..translate(screenWidth),
      child: SlideTransition(
        position: sliderAnimation,
        textDirection: TextDirection.rtl,
        child: DecoratedText(
            color: blackColor,
            fontSize: fontSize2,
            fontWeight: fontWeight4,
            text: '${widget.numberOfTodos} $todosAdded',
          ),
      ),
    );
  }
}