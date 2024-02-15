import 'package:flutter/material.dart';

class ScrollBarWithSingleChildScrollView extends StatelessWidget {
  final Widget child;

  const ScrollBarWithSingleChildScrollView({
    super.key,
    required this.child
  });

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      radius: const Radius.circular(5), 
      controller: PrimaryScrollController.of(context),             
      thickness: 10,
      child: Center(
        child: SingleChildScrollView(
          controller: PrimaryScrollController.of(context),
          child: child
        ),
      )
    );
  }
}