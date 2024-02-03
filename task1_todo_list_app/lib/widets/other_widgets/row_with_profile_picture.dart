import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:task1_todo_list_app/constants/colors.dart';
import 'package:task1_todo_list_app/constants/extensions.dart';
import 'package:task1_todo_list_app/constants/fontsizes.dart';
import 'package:task1_todo_list_app/constants/fontweights.dart';
import 'package:task1_todo_list_app/constants/strings.dart';
import 'package:task1_todo_list_app/widets/custom_widgets/decorated_text_widget.dart';

class RowWithProfilePicture extends StatelessWidget {
  final Uint8List? imageBytes;
  final String? username;

  const RowWithProfilePicture({
    super.key,
    required this.imageBytes,
    required this.username
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: const Border().modify(purpleColor, 2)
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: imageBytes != null 
              ? Image.memory(
                imageBytes!,
                fit: BoxFit.cover
              )
              : const Icon(Icons.person),
          ),
        ),
        const Gap(20),        
        Expanded(
          child: DecoratedText(
            color: blackColor,
            fontSize: fontSize4,
            fontWeight: fontWeight7,
            text: '$hello ${username ?? newUser}',          
          ),
        ),
      ],
    );
  }
}