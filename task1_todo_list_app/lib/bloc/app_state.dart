import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';


@immutable 
abstract class AppState {
  final String id;
  final bool? isLoading;
  final String? operation,
  alertContent, alert, error;

  AppState({
    this.isLoading,
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
  final bool? editUserDetails;

  InGetUserDataViewAppState({
    this.username,
    this.fileNameToDisplay,
    this.imageFile,
    this.editUserDetails,
    bool? isLoading,
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


@immutable 
class InLandingPageViewAppState extends AppState{

  InLandingPageViewAppState({
    String? operation,
    bool? isLoading,
    String? alert,
    String? error,
    String? alertContent
  }): super(
    isLoading: isLoading,
    operation: operation,
    alert: alert,
    error: error,
    alertContent: alertContent
  );
}


@immutable 
class InTodoHomeViewAppState extends AppState{
  final String? username,
  indexToShow;
  final Iterable<List<String>?> retrievedTodos;
  final Uint8List? imageBytes;
  final bool? isZoomed;

  InTodoHomeViewAppState({
    required this.retrievedTodos,
    this.imageBytes,
    this.username,
    this.indexToShow,
    this.isZoomed,
    bool? isLoading,
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
  final String? dueDateTime;
  
  InAddTodoViewAppState({
    this.isInUpdateMode,
    this.initialTodo,
    this.dueDateTime,
    bool? isLoading,
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