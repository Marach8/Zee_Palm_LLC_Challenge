import 'package:flutter/material.dart';

class ScrollBarWithSingleChildScrollView extends StatelessWidget {
  final double? thickness;
  final Widget child;

  const ScrollBarWithSingleChildScrollView({
    super.key,
    this.thickness,
    required this.child
  });

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      //interactive: true,
      radius: const Radius.circular(5), 
      controller: PrimaryScrollController.of(context),             
      thickness: thickness ?? 10,
      child: Center(
        child: SingleChildScrollView(
          controller: PrimaryScrollController.of(context),
          child: child
        ),
      )
    );
  }
}