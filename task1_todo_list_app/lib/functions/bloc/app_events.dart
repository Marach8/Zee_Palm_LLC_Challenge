import 'package:flutter/material.dart';

@immutable
abstract class AppEvents{
  const AppEvents();
}


//Events in Landing Page View
@immutable 
class InitializationAppEvent extends AppEvents{
  const InitializationAppEvent();
}

@immutable 
class GetUserPermissionAppEvent extends AppEvents{
  const GetUserPermissionAppEvent();
}

@immutable 
class ShowAppPermissionReasonEvent extends AppEvents{
  const ShowAppPermissionReasonEvent();
}


//Events in GetUserData View
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
  const GoToTodoHomeAppEvent();
}

@immutable 
class SaveUserDataAppEvent extends AppEvents{
  final String username;

  const SaveUserDataAppEvent({
    required this.username,
  });
}

@immutable 
class SkipUserDataAppEvent extends AppEvents{
  final String username;

  const SkipUserDataAppEvent({
    required this.username
  });
}


//Events in Todo Home View
@immutable 
class ResetIndexToShowAppEvent extends AppEvents{
  const ResetIndexToShowAppEvent();
}

@immutable 
class GoToAddTodoViewAppEvent extends AppEvents{
  const GoToAddTodoViewAppEvent();
}

@immutable 
class DeleteTodoAppEvent extends AppEvents{
  final String indexToDelete;
  const DeleteTodoAppEvent({
    required this.indexToDelete
  });
}

@immutable
class ConfirmUpdateTodoIsCompletedAppEvent extends AppEvents{
  final String indexToUpdate;
  final List<String> newTodo;
  final bool? isCompleted;

  const ConfirmUpdateTodoIsCompletedAppEvent({
    required this.indexToUpdate,
    required this.newTodo,
    this.isCompleted
  });
}

@immutable 
class UpdateTodoIsCompletedStateAppEvent extends AppEvents{
  const UpdateTodoIsCompletedStateAppEvent();
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

@immutable 
class ZoomProfilePicAppEvent extends AppEvents{
  final bool isZoomed;
  
  const ZoomProfilePicAppEvent({
    required this.isZoomed
  });
}

@immutable 
class WantToGoToGetUserDataViewAppEvent extends AppEvents{
  const WantToGoToGetUserDataViewAppEvent();
}

@immutable 
class ShowCompletedTodosAppEvent extends AppEvents{
  const ShowCompletedTodosAppEvent();
}



//Events in Add Todo View
@immutable 
class GetDateAndTimeAppEvent extends AppEvents{
  final BuildContext context;
  const GetDateAndTimeAppEvent({
    required this.context
  });
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


//Event that is in Landing Page View and In Todo Home View
@immutable 
class GoToGetUserDataViewAppEvent extends AppEvents{
  const GoToGetUserDataViewAppEvent();
}