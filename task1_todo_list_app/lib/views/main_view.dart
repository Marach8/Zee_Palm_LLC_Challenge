// import 'dart:math';

// import 'package:flutter/material.dart';

// class MainTodoView extends StatefulWidget {
//   const MainTodoView({super.key});

//   @override
//   State<MainTodoView> createState() => _MainTodoViewState();
// }

// class _MainTodoViewState extends State<MainTodoView> with TickerProviderStateMixin{
  
//   late AnimationController basicController, scientificController;
//   late Animation<double> basicAnimation, scientificAnimation;

//   @override 
//   void initState(){
//     super.initState();
//     basicController = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 1)
//     );

//     scientificController = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 1)
//     );

//     basicAnimation = Tween<double>(begin: 0, end: -pi/2).animate(basicController);
//     scientificAnimation = Tween<double>(begin: pi/2.7, end: 0).animate(scientificController);
//   }

//   @override 
//   void dispose(){
//     basicController.dispose();
//     scientificController.dispose();
//     super.dispose();
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     return AnimatedBuilder(
//       animation: Listenable.merge([basicController, scientificController]),
//       builder: (_, __) => Stack(
//         children: [
//           Container(color: Colors.white),
//           Transform(
//             alignment: Alignment.centerLeft,
//             transform: Matrix4.identity()
//               ..setEntry(3, 2, 0.001)
//               ..translate(basicController.value * width)
//               ..rotateY(basicAnimation.value),
//             child: BasicView(
//               controller1: basicController, 
//               controller2: scientificController
//             )
//           ),
//           Transform(
//             alignment: Alignment.centerRight,
//             transform: Matrix4.identity()
//               ..setEntry(3, 2, 0.001)
//               ..translate(-width + scientificController.value * width)
//               ..rotateY(scientificAnimation.value),
//             child: ScientificView(
//               controller1: basicController, 
//               controller2: scientificController
//             )
//           ),
//         ]
//       ),
//     );
//   }
// }