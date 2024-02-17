import 'dart:io';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart' show Uint8List;
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:task1_todo_list_app/src/constants/strings.dart';
import 'package:task1_todo_list_app/src/models/todo_model.dart';
import 'package:task1_todo_list_app/src/models/user_details_model.dart';


class AppBackend {
  AppBackend._sharedInstance();
  static final AppBackend _shared = AppBackend._sharedInstance();
  factory AppBackend() => _shared;

  Future<Box<Todo>> _openTodoBox() async{
    if(Hive.isBoxOpen(todoString)){
      return Hive.box<Todo>(todoString);
    }
    else{
      return await Hive.openBox<Todo>(todoString);
    }
  }
    
  Future<Box<UserDetails>> _openUserDetailsBox() async {
    if(Hive.isBoxOpen(userDetailsString)){
      return Hive.box<UserDetails>(userDetailsString);
    }
    else{
      return await Hive.openBox<UserDetails>(userDetailsString);
    }
  }
    

  int? numberOfTodos;


  Future<void> createUserDetails({
    required bool userExists,
    String? username,
    String? imageFileName,
    Uint8List? imageData,
  }) async => await _openUserDetailsBox().then(
    (box) async => await box.put(
      userDetailsString,
      UserDetails(
        userExists: userExists,
        username: username,
        imageData: imageData,
        imageFileName: imageFileName
      )
    )
  );


  Future<UserDetails?> getUserDetails() async => 
    await _openUserDetailsBox().then(
      (box) async {
        final detailsOfUser = box.get(userDetailsString);
        return detailsOfUser;
      }
    );


  Future<List<dynamic>?> pickImage() async{
    final imagePicker = ImagePicker();
    final file = await imagePicker.pickImage(
      source: ImageSource.gallery
    );
    if(file != null){
      final imageFile = File(file.path);
      final imageData = await file.readAsBytes();
      final imageFileName = imageFile.path.split(slashString).last;
      return [imageData, imageFileName];
    }
    return null;
  }


  Future<void> updateUserDetails({
    required dynamic update,
    required String fieldToUpdate
  }) async => await _openUserDetailsBox().then(
    (box) {
      final detailsOfUser = box.get(userDetailsString);

      if (detailsOfUser != null){
        switch(fieldToUpdate){
          case usernameField:
            detailsOfUser.username = update as String;
            break;
          case imageFileNameField:
            detailsOfUser.imageFileName = update as String;
            break;
          case imageDataField:
            detailsOfUser.imageData = update as Uint8List;
            break;
          case userExistsField:
            detailsOfUser.userExists = update as bool;
        }

        box.put(userDetailsString, detailsOfUser);
      }
    }
  );

  


  //For Todos
  Future<void> addNewTodo({
    required String todoTitle,
    required String todoDueDateTime,
    required String todoContent
  }) async
    => await _openTodoBox().then(
      (box) async {
        final currentDateTime = DateTime.now();
        final creationDateTime = DateFormat(dateFormatString)
          .format(currentDateTime);
        const defaultIsCompleted = false;

        await box.add(
          Todo(
            todoTitle: todoTitle, 
            todoCreationDateTime: creationDateTime, 
            todoContent: todoContent, 
            todoDueDateTime: todoDueDateTime, 
            todoIsCompleted: defaultIsCompleted
          )
        );
        numberOfTodos = box.values.length;
      }
    );


  Future<bool> updateExistingTodo ({
    required String titleToUpdate,
    required String dueDateTimeToUpdate,
    required String contentToUpdate,
    required String keyId
  }) async => await _openTodoBox().then(
    (box) async{
      final todoToUpdate = box.values.firstWhere(
        (todo) => todo.todoKey == keyId
      );
      
      final oldTitle = todoToUpdate.todoTitle;
      final oldDueDateTime = todoToUpdate.todoDueDateTime;
      final oldContent = todoToUpdate.todoContent;
      
      final oldTodo = [oldTitle, oldDueDateTime, oldContent];
      final newTodo = [titleToUpdate, dueDateTimeToUpdate, contentToUpdate];

      final theyAreEqual = const DeepCollectionEquality().equals(oldTodo, newTodo);
      if(theyAreEqual){
        return false;
      }

      else{
        final updatedTodo = todoToUpdate.copyTodo(
          title: titleToUpdate,
          dueDateTime: dueDateTimeToUpdate,
          content: contentToUpdate
        );
        await box.add(updatedTodo).then((_) async {
          await todoToUpdate.delete();
        });
        return true;
      }
    }
  );

  
  //This will return an empty iterable if there are no pending todos
  Future<Iterable<Todo>> getPendingTodos() async =>
    await _openTodoBox().then(
      (box) async {
        final todos = box.values.where(
          (todo) => todo.todoIsCompleted == false
        );
        return todos;
      }
    );


  //This will return an empty iterable if there are no completed todos
  Future<Iterable<Todo>> getCompletedTodos() async =>
    await _openTodoBox().then(
      (box) async {
        final todos = box.values.where(
          (todo) => todo.todoIsCompleted == true
        );
        return todos;
      }
    );

  Future<void> updateTodoIsCompletedState({
    required String keyId
  }) async => await _openTodoBox().then(
      (box) async {
        final todoToUpdate = box.values.firstWhere(
          (todo) => todo.todoKey == keyId
        );

        final newIsCompletedState = !todoToUpdate.todoIsCompleted;
        final updatedTodo = todoToUpdate.copyTodo(
          isCompleted: newIsCompletedState
        );
        await box.add(updatedTodo).then((_) async {
          await todoToUpdate.delete();
        });
      }
    );


  Future<void> deleteTodo({required String keyId}) async => 
    await _openTodoBox().then(
      (box) => box.values.firstWhere(
        (todo) => todo.todoKey == keyId
      ).delete()
    );
}

  // //Save image file to local directory
  // Future<void> saveImageFile(File file) async{
  //   final prefs = await getPreference();
  //   final appDocDirectory = await getApplicationDocumentsDirectory();
  //   final fileExtension = file.path.split(dotString).last;
  //   final newFilePath = join(
  //     appDocDirectory.path, 
  //     hello+dotString+fileExtension
  //   );
  //   await prefs.setString(newFilePathString, newFilePath);
  //   await file.copy(newFilePath);
  // }


//   //Retrieve image data from local directory
//   Future<Uint8List?>? retrieveImageData() async{
//     final prefs = await getPreference();
//     final newFilePath = prefs.getString(newFilePathString);
//     if(newFilePath != null){
//       final newFile = File(newFilePath);
//       if(await newFile.exists()){
//         final imageBytes = await newFile.readAsBytes();
//         return imageBytes;
//       }
//     }
//     return null;
//   }
// }