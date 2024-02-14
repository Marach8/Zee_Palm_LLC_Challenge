import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget {
  final Color color;

  const DividerWidget({
    super.key,
    required this.color
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color,
      thickness: 0.2
    );
  }
}