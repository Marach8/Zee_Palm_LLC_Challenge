import 'package:flutter/material.dart';
import 'package:task1_todo_list_app/constants/colors.dart';
import 'package:task1_todo_list_app/constants/fontsizes.dart';
import 'package:task1_todo_list_app/constants/fontweights.dart';
import 'package:task1_todo_list_app/constants/strings.dart';

extension ModifyText on Text{
  Text decorateWithGoogleFont(
    Color color, 
    FontWeight fontWeight,
    double fontSize,
    [bool? controlOverflow]
  ) => Text(
    data ?? '', 
    style: TextStyle(
      fontFamily: quickSandFont,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color
    ),
    overflow: controlOverflow ?? false ? TextOverflow.ellipsis : null,
    softWrap: true,   
  );
}


extension DecorateTextSpan on TextSpan{
  TextSpan decorateTextSpan(
    Color color, 
    double fontSize, 
    FontWeight fontWeight,
    [bool? controlOverflow]
  ) => TextSpan(
    text: text,
    style: TextStyle(
      fontFamily: quickSandFont,
      color: color, 
      fontSize: fontSize,
      fontWeight: fontWeight,
      overflow: controlOverflow ?? false ? TextOverflow.ellipsis : null,
    )
  );
}


extension ModifyBorder on Border{
  Border modifyBorder(Color color, double width) => Border.all(
    color: color, width: width,
  );
}


extension ControlHeight on SizedBox{
  SizedBox dynamicHeight(int variable){
    double height = 0;
    
    if(variable == 1){
      height = 100.0;
    }
    else if(variable == 2){
      height = 200;
    }
    else if(variable == 3){
      height = 300;
    }
    else {
      height = 400;
    }
    return SizedBox(
      height: height,
      child: child,
    );
  }
}


extension CheckEquality on List{
  bool listsAreEqual(List other){
    if(
      [0] == other[0] &&
      [1] == other[1] &&
      [2] == other[2]
    ){
      return true;
    }
    return false;
  }
}


extension YesOrNo on String{
  String yesOrNo() => 
    this == trueString ? yesString : noString;
}


extension ChooseText on TextEditingController{
  TextEditingController chooseText(
    String? text1, 
    String? text2,
  ){
    if(text1 != null){
      return TextEditingController(text: text1);
    }
    else if(text2 != null){
      return TextEditingController(text: text2);
    }
    else{
      return TextEditingController(text: emptyString);
    }
  }
}


extension ApplyDecoratedText on List<Text>{
  List<Text> applyDecoratedText(){
    for(final textItem in this){
      if(textItem == this[2]){
        continue;
      }
      textItem.decorateWithGoogleFont(
        blackColor,
        fontWeight1,
        fontSize1
      );
    }
    return this;
  }
}