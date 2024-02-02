import 'dart:io';

import 'package:flutter/material.dart';

@immutable 
abstract class AppState {
  final bool isLoading;
  final String? error;

  const AppState({
    required this.isLoading,
    this.error
  });
}


@immutable 
class InGetUserDataViewAppState extends AppState{
  final String? username,
  fileNameToDisplay;
  final File? imageFile;

  const InGetUserDataViewAppState({
    required bool isLoading,
    this.username,
    this.fileNameToDisplay,
    this.imageFile,
    String? error
  }): super(
    isLoading: isLoading,
    error: error
  );
}


@immutable 
class InLandingPageViewAppState extends AppState{
  const InLandingPageViewAppState({
    required bool isLoading
  }): super(isLoading: isLoading);
}


@immutable 
class InTodoHomeViewAppState extends AppState{
  final String? username;
  final File? imageFile;

  const InTodoHomeViewAppState({
    required bool isLoading,
    required this.username,
    required this.imageFile,
    String? error
  }): super(
    isLoading: isLoading,
    error: error
  );
}