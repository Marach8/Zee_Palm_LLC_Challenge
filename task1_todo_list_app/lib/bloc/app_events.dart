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
class SaveUserDetailsAndGoToTodoHomeAppEvent extends AppEvents{
  final String username;
  const SaveUserDetailsAndGoToTodoHomeAppEvent({
    required this.username
  });
}

@immutable 
class SkipUserDetailsAndGoToTodoHomeAppEvent extends AppEvents{
  const SkipUserDetailsAndGoToTodoHomeAppEvent();
}

@immutable 
class InitializationAppEvent extends AppEvents{
  const InitializationAppEvent();
}