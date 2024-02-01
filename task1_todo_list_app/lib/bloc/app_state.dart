import 'package:flutter/material.dart';

@immutable 
abstract class AppState {
  final bool isLoading;
  const AppState({required this.isLoading});
}


@immutable 
class InGetUserDataViewAppState extends AppState{
  const InGetUserDataViewAppState({
    required bool isLoading
  }): super(isLoading: isLoading);
}


@immutable 
class InLandingPageViewAppState extends AppState{
  final bool inStep1;

  const InLandingPageViewAppState({
    required this.inStep1,
    required bool isLoading
  }): super(isLoading: isLoading);
}