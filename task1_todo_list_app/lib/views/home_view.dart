import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:task1_todo_list_app/constants/strings.dart';

class TodoHome extends StatelessWidget {
  const TodoHome ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.black,
                    child: Icon(
                      Icons.play_arrow, 
                      color: Colors.white
                    )
                  )
                ]
              ),
              Lottie.asset(
                lottie3Path,
                fit: BoxFit.cover
              ),
              const Gap(20),
              Container(
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (){}, 
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.white60),
                    foregroundColor: MaterialStatePropertyAll(Colors.black)
                  ),
                  child: const Text('Get Started...'),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}