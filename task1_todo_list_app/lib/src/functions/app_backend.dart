import 'dart:io';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart' show Uint8List, kIsWeb;
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1_todo_list_app/src/constants/strings.dart';
import 'package:task1_todo_list_app/src/models/todo_model.dart';
import 'package:task1_todo_list_app/src/models/user_details_model.dart';
import 'dart:developer' as marach show log;

class AppBackend {
  AppBackend._sharedInstance();
  static final AppBackend _shared = AppBackend._sharedInstance();
  factory AppBackend() => _shared;

  Future<Box<Todo>> _openTodoBox() async => 
    await Hive.openBox<Todo>(todoString);
    
  Future<Box<UserDetails>> _openUserDetailsBox() async =>
    await Hive.openBox<UserDetails>(userDetailsString);
    
  Future<void> _closeBox() async => await Hive.close();

  


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
  ).then((_) async => await _closeBox());


  Future<UserDetails?> getUserDetails() async => 
    await _openUserDetailsBox().then(
      (box) async {
        final detailsOfUser = box.get(userDetailsString);
        await _closeBox();
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
      marach.log('imageData was obtained');
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
  ).then((_) async => await _closeBox());


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
      }
    ).then((_) async => await _closeBox());


  Future<String> updateExistingTodo ({
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
        return noString;
      }

      else{
        final newTodo = todoToUpdate.copyTodo(
          title: titleToUpdate,
          dueDateTime: dueDateTimeToUpdate,
          content: contentToUpdate
        );
        await box.add(newTodo).then((_) async {
          await todoToUpdate.delete();
        });
        return yesString;
      }
    }
  ).then((result) async {
    await _closeBox();
    return result;
  });
















  Future<SharedPreferences> getPreference() async => 
    kIsWeb ? await SharedPreferences.getInstance() 
    : await SharedPreferences.getInstance();


  // Future<SharedPreferences> get preferences async 
  //   => await SharedPreferences.getInstance();

  
  Future<bool> setUserExists() async 
    => await getPreference().then(
      (prefs) => prefs.setBool('', true)
    );


  Future<bool?> getUserExists() async 
    => await getPreference().then(
      (prefs) => prefs.getBool('')
    );


  Future<bool?> setLatestTodoCount(int latestCount) async{
    final prefs = await getPreference();
    return await prefs.setInt(latestTodoCount, latestCount);
  }


  Future<int> getLatestTodoCount() async{
    final prefs = await getPreference();
    return prefs.getInt(latestTodoCount) ?? 0;
  }


  

  Future<bool> setTodo(List<String> todoDetails) async{
    final prefs = await getPreference();
    return await getLatestTodoCount().then((lastCount) async{
      lastCount ++;

      await setLatestTodoCount(lastCount);
      final currentDateTime = DateTime.now();
      final creationDateTime = DateFormat(dateFormatString)
        .format(currentDateTime);

      todoDetails.addAll(
        [falseString, creationDateTime, '$lastCount']
      );
      return await prefs.setStringList(
        todoString+lastCount.toString(), 
        todoDetails
      );
    });
  }


  Future<bool> updateTodo(List<String> newTodo, String index) async{
    final prefs = await getPreference();
    return await prefs.setStringList(todoString+index, newTodo);
  }


  Future<bool> deleteTodo(String todoToDelete) async{
    final prefs = await getPreference();
    return prefs.remove(todoToDelete);
  }


  Future<List<String>?> getTodo(String index) async{
    final prefs = await getPreference();
    return prefs.getStringList(todoString+index);
  }


  Future<Iterable<List<String>?>> getCompletedTodos() async{
    final prefs = await getPreference();
    final latestCount = await getLatestTodoCount();
    
    final listOfTodos = Iterable.generate(
      latestCount,
      (index) {
        final stringIndex = '${index + 1}';
        return prefs.getStringList(todoString+stringIndex);
      }
    )
    .where((todo) => todo != null)
    .where((todo) => todo![3] == trueString)
    .takeWhile((todo) => todo != null);
    return listOfTodos;
  }


  Future<Iterable<List<String>?>> getPendingTodos() async{
    final prefs = await getPreference();
    final latestCount = await getLatestTodoCount();
    
    final listOfTodos = Iterable.generate(
      latestCount,
      (index) {
        final stringIndex = '${index + 1}';
        return prefs.getStringList(todoString+stringIndex);
      }
    )
    .where((todo) => todo != null)
    .where((todo) => todo![3] == falseString)
    .takeWhile((todo) => todo != null);
    return listOfTodos;
  }



  //Save image file to local directory
  Future<void> saveImageFile(File file) async{
    final prefs = await getPreference();
    final appDocDirectory = await getApplicationDocumentsDirectory();
    final fileExtension = file.path.split(dotString).last;
    final newFilePath = join(
      appDocDirectory.path, 
      hello+dotString+fileExtension
    );
    await prefs.setString(newFilePathString, newFilePath);
    await file.copy(newFilePath);
  }


  //Retrieve image data from local directory
  Future<Uint8List?>? retrieveImageData() async{
    final prefs = await getPreference();
    final newFilePath = prefs.getString(newFilePathString);
    if(newFilePath != null){
      final newFile = File(newFilePath);
      if(await newFile.exists()){
        final imageBytes = await newFile.readAsBytes();
        return imageBytes;
      }
    }
    return null;
  }
}