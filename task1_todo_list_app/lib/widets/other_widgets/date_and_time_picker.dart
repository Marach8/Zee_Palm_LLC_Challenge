import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:developer' as marach show log;

import 'package:task1_todo_list_app/constants/strings.dart';

Future<String?> selectedDueDateTime(BuildContext context) async{
  late String date, time;
  await showDatePicker(
    context: context, 
    firstDate: DateTime(2024),
    lastDate: DateTime(2050)
  )
  .then((dateObject) async{
    await showTimePicker(
      context: context, 
      initialTime: TimeOfDay.now()
    )
    .then((timeObject){
      if(dateObject != null){
        final dateString = DateFormat('EEEE, dd MMM yyyy').format(dateObject);
        date = dateString;
      }
      else{
        date = emptyString;
      }

      if(timeObject != null){
        final hour = timeObject.hour;
        final minute = timeObject.minute;
        final period = timeObject.period.name.toUpperCase();
        final timeString = '$hour:$minute $period';
        time = timeString;
      }
      else{
        time = emptyString;
      }
      
    });
  });
  return '$date $time';
}