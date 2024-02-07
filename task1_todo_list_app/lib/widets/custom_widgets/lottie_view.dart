import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieView extends StatelessWidget {
  final String lottiePath;
  
  const LottieView({
    super.key,
    required this.lottiePath
  });

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      lottiePath,
      fit: BoxFit.contain
    );
  }
}