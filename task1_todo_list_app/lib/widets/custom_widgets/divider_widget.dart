import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget {
  final Color color;

  const DividerWidget({
    super.key,
    required this.color
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Divider(
        color: color,
        thickness: 0.1
      ),
    );
  }
}