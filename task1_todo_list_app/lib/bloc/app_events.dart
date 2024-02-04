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
class GoToAddTodoViewAppEvent extends AppEvents{
  const GoToAddTodoViewAppEvent();
}

@immutable 
class SaveTodoAppEvent extends AppEvents{
  final TextEditingController titleController, 
  dueDateTimeController, contentController;

  const SaveTodoAppEvent({
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
class UpdateTodoIsCompletedState extends AppEvents{
  final String indexToUpdate;
  final List<String> newTodo;

  const UpdateTodoIsCompletedState({
    required this.indexToUpdate,
    required this.newTodo
  });
}

@immutable 
class ContinueToDismissAppEvent extends AppEvents{
  const ContinueToDismissAppEvent();
}