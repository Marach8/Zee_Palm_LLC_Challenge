import 'dart:io';

import 'package:flutter/material.dart';

@immutable 
abstract class AppState {
  final bool isLoading;
  const AppState({required this.isLoading});
}


@immutable 
class InGetUserDataViewAppState extends AppState{
  final String? username,
  fileNameToDisplay;
  final File? imageFile;

  const InGetUserDataViewAppState({
    required bool isLoading,
    required this.username,
    required this.fileNameToDisplay,
    required this.imageFile
  }): super(isLoading: isLoading);
}


@immutable 
class InLandingPageViewAppState extends AppState{
  const InLandingPageViewAppState({
    required bool isLoading
  }): super(isLoading: isLoading);
}