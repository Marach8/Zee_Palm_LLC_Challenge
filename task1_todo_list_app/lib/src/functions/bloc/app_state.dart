import 'dart:typed_data' show Uint8List;
import 'package:flutter/material.dart';
import 'package:task1_todo_list_app/src/models/todo_model.dart';
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
  fileNameToDisplay,
  initialFileNameToDisplay;
  final Uint8List? imageBytes;
  final bool? inEditUserDetailsMode;

  InGetUserDataViewAppState({
    this.username,
    this.fileNameToDisplay,
    this.initialFileNameToDisplay,
    this.imageBytes,
    this.inEditUserDetailsMode,
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
  todoKeyToShow, todoKeyToUpdate;
  final bool? isZoomed, wantsToUpdateUserDetails,
  showCompletedTodos, useMemoizedDependency;

  InTodoHomeViewAppState({
    this.username,
    this.todoKeyToShow,
    this.isZoomed,
    this.todoKeyToUpdate,
    this.wantsToUpdateUserDetails,
    this.showCompletedTodos,
    this.useMemoizedDependency,
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
  final Todo? initialTodo;
  final String? dueDateTime;
  final int? numberOfTodos;
  
  InAddTodoViewAppState({
    this.isInUpdateMode,
    this.initialTodo,
    this.dueDateTime,
    this.numberOfTodos,
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