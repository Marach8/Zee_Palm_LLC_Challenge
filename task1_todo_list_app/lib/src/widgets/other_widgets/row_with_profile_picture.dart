import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:task1_todo_list_app/src/functions/app_backend.dart';
import 'package:task1_todo_list_app/src/functions/bloc/app_bloc.dart';
import 'package:task1_todo_list_app/src/functions/bloc/app_events.dart';
import 'package:task1_todo_list_app/src/constants/colors.dart';
import 'package:task1_todo_list_app/src/constants/extensions.dart';
import 'package:task1_todo_list_app/src/constants/fontsizes.dart';
import 'package:task1_todo_list_app/src/constants/fontweights.dart';
import 'package:task1_todo_list_app/src/constants/strings.dart';
import 'package:task1_todo_list_app/src/widgets/custom_widgets/decorated_text_widget.dart';
import 'package:task1_todo_list_app/src/widgets/other_widgets/empty_widget.dart';

class RowWithProfilePicture extends HookWidget {
  final bool isZoomed;
  const RowWithProfilePicture({
    super.key,
    required this.isZoomed
  });

  @override
  Widget build(BuildContext context) {
    final backend = AppBackend();

    //Cache the username and imageData.
    final usernameFuture = useMemoized(() => backend.getUsername());
    final imagedataFuture = useMemoized(() => backend.retrieveImageData());
    final usernameSnapshot = useFuture(usernameFuture);
    final imageDataSnapshot = useFuture(imagedataFuture);

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            curve: Curves.bounceInOut,
            duration: const Duration(milliseconds: 300),
            height: isZoomed ? 260 : 80,
            width: isZoomed ? 260: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: const Border().modifyBorder(purpleColor, 2)
            ),
            child: GestureDetector(
              onTap: () => context.read<AppBloc>().add(
                ZoomProfilePicAppEvent(
                  isZoomed: isZoomed == true ? false : true
                )
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  isZoomed ? 130 : 40
                ),
                child: imageDataSnapshot.hasData && 
                  imageDataSnapshot.data != null ? Image.memory(
                    imageDataSnapshot.data!,
                    fit: BoxFit.cover
                  ) : const Icon(Icons.person),
              ),
            ),
          ),
          const Gap(20),        
          isZoomed ? emptySizedBox
          :Expanded(
            child: DecoratedText(
              color: blackColor,
              fontSize: fontSize4,
              fontWeight: fontWeight7,
              text: usernameSnapshot.hasData && 
                usernameSnapshot.data != null ?
                '$hello ${usernameSnapshot.data}':
                '$hello $newUser'         
            ),
          ),
        ],
      ),
    );
  }
}