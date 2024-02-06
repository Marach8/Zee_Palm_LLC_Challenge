import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';


@immutable 
abstract class AppState {
  final String id;
  final bool isLoading;
  final String? operation,
  alertContent, alert, error;

  AppState({
    required this.isLoading,
    this.error,
    this.operation,
    this.alert,
    this.alertContent
  }): id = const Uuid().v4();

  @override 
  bool operator ==(covariant AppState other)
    => identical(this, other) &&
      id == other.id;

  @override 
  int get hashCode => id.hashCode;
  }


@immutable 
class InGetUserDataViewAppState extends AppState{
  final String? username,
  fileNameToDisplay;
  final File? imageFile;

  InGetUserDataViewAppState({
    required bool isLoading,
    this.username,
    this.fileNameToDisplay,
    this.imageFile,
    String? error,
    String? operation,
  }): super(
    isLoading: isLoading,
    error: error,
    operation: operation
  );
}


@immutable 
class InLandingPageViewAppState extends AppState{

  InLandingPageViewAppState({
    String? operation,
    required bool isLoading,   
  }): super(
    isLoading: isLoading,
    operation: operation
  );
}


@immutable 
class InTodoHomeViewAppState extends AppState{
  final String? username;
  final File? imageFile;
  final Iterable<List<String>?> retrievedTodos;
  final Uint8List? imageBytes;
  final bool? shouldDelete;

  InTodoHomeViewAppState({
    required bool isLoading,
    required this.retrievedTodos,
    this.imageBytes,
    this.username,
    this.imageFile,
    this.shouldDelete,
    String? error,
    String? operation,
    String? alert,
    String? alertContent,
  }): super(
    isLoading: isLoading,
    error: error,
    operation: operation,
    alert: alert,
    alertContent: alertContent
  );
}


@immutable 
class InAddTodoViewAppState extends AppState{
  final bool? isInUpdateMode;
  final List<String>? initialTodo;
  
  InAddTodoViewAppState({
    this.isInUpdateMode,
    this.initialTodo,
    required bool isLoading,
    String? error,
    String? operation,
    String? alert,
    String? alertContent
  }): super(
    isLoading: isLoading,
    error: error,
    operation: operation,
    alert: alert,
    alertContent: alertContent
  );
}