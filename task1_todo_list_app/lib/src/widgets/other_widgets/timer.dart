import 'package:flutter/material.dart';
import 'package:task1_todo_list_app/src/constants/colors.dart';
import 'package:task1_todo_list_app/src/constants/fontsizes.dart';
import 'package:task1_todo_list_app/src/constants/fontweights.dart';
import 'package:task1_todo_list_app/src/widgets/custom_widgets/decorated_text_widget.dart';


class CountDownTimerView extends StatelessWidget {
  final int duration;
  final Color color;

  const CountDownTimerView({
    super.key,
    required this.color,
    required this.duration
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Stream.periodic(
        const Duration(seconds: 1), 
        (time) => duration - time
      ).take(duration + 1), 
      builder: (_, snapshot) => CircleAvatar(
        backgroundColor: whiteColor,
        radius: 10,
        child: snapshot.hasData ? 
          Center(
            child: DecoratedText(
              text: snapshot.data!.toString(), 
              color: color, 
              fontSize: fontSize2, 
              fontWeight: fontWeight5
            ),
          ) : const Text('')
      )
    );
  }
}