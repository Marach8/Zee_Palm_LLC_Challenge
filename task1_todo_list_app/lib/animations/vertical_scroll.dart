import 'package:flutter/material.dart';

class VerticalScrollWidget extends StatefulWidget {
  const VerticalScrollWidget({super.key});

  @override
  State<VerticalScrollWidget> createState() => _VerticalScrollWidgetState();
}

class _VerticalScrollWidgetState extends State<VerticalScrollWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}