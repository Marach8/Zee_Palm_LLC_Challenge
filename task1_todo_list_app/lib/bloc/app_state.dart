import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

@immutable 
abstract class AppState {
  final bool isLoading;
  final String? error;
  final String? operation;

  const AppState({
    required this.isLoading,
    this.error,
    this.operation
  });
}


@immutable 
class InGetUserDataViewAppState extends AppState{
  final String? username,
  fileNameToDisplay;
  final File? imageFile;
  final int? counter;

  const InGetUserDataViewAppState({
    required bool isLoading,
    this.username,
    this.fileNameToDisplay,
    this.imageFile,
    String? error,
    String? operation,
    this.counter
  }): super(
    isLoading: isLoading,
    error: error,
    operation: operation
  );
}


@immutable 
class InLandingPageViewAppState extends AppState{

  const InLandingPageViewAppState({
    required bool isLoading,   
  }): super(isLoading: isLoading);
}


@immutable 
class InTodoHomeViewAppState extends AppState{
  final String? username;
  final File? imageFile;
  final Iterable<List<String>?>? retrievedTodos;
  final Uint8List? imageBytes;

  const InTodoHomeViewAppState({
    required bool isLoading,
    this.retrievedTodos,
    this.imageBytes,
    this.username,
    this.imageFile,
    String? error,
    String? operation
  }): super(
    isLoading: isLoading,
    error: error,
    operation: operation
  );
}