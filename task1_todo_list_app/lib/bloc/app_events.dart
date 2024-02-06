import 'package:flutter/material.dart';

@immutable
abstract class AppEvents{
  const AppEvents();
}

@immutable 
class GoToGetUserDataViewAppEvent extends AppEvents{
  const GoToGetUserDataViewAppEvent();
}

@immutable 
class GoToLandingPageAppEvent extends AppEvents{
  const GoToLandingPageAppEvent();
}

@immutable 
class AddPhotoAppEvent extends AppEvents{
  const AddPhotoAppEvent();
}

@immutable 
class GoToTodoHomeAppEvent extends AppEvents{
  final String? username;
  const GoToTodoHomeAppEvent({
    this.username
  });
}

@immutable 
class InitializationAppEvent extends AppEvents{
  const InitializationAppEvent();
}

@immutable 
class ResetIndexToShowAppEvent extends AppEvents{
  const ResetIndexToShowAppEvent();
}

@immutable 
class GoToAddTodoViewAppEvent extends AppEvents{
  const GoToAddTodoViewAppEvent();
}

@immutable 
class SaveOrUpdateTodoAppEvent extends AppEvents{
  final TextEditingController titleController, 
  dueDateTimeController, contentController;

  const SaveOrUpdateTodoAppEvent({
    required this.titleController,
    required this.dueDateTimeController,
    required this.contentController
  });
}

@immutable 
class DeleteTodoAppEvent extends AppEvents{
  final String indexToDelete;
  const DeleteTodoAppEvent({
    required this.indexToDelete
  });
}

@immutable 
class UpdateTodoIsCompletedStateAppEvent extends AppEvents{
  final String indexToUpdate;
  final List<String> newTodo;

  const UpdateTodoIsCompletedStateAppEvent({
    required this.indexToUpdate,
    required this.newTodo
  });
}

@immutable 
class StartTodoUpdateAppEvent extends AppEvents{
  final String indexToUpdate;

  const StartTodoUpdateAppEvent({
    required this.indexToUpdate,
  });
}

@immutable 
class ShowFullTodoDetailsAppEvent extends AppEvents{
  final String indexToShow;
  
  const ShowFullTodoDetailsAppEvent({
    required this.indexToShow
  });
}