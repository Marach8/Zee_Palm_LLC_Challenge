import 'package:flutter/material.dart';

@immutable
abstract class AppEvents{
  const AppEvents();
}

@immutable 
class GoToGetUserDataViewAppEvent extends AppEvents{
  const GoToGetUserDataViewAppEvent();
}
