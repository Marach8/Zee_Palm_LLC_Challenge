import 'dart:io';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1_todo_list_app/constants/strings.dart';


class AppBackend {
  AppBackend._sharedInstance();
  static final AppBackend _shared = AppBackend._sharedInstance();
  factory AppBackend() => _shared;

  Future<SharedPreferences> get preferences async 
    => await SharedPreferences.getInstance();

  Future<bool> setUsername(String username) async{
    final prefs = await preferences;
    return await prefs.setString(usernameString, username);
  }

  Future<String?>? getUsername(String username) async{
    final prefs = await preferences;
    return prefs.getString(username);
  }

  Future<bool> setTodo(List<String> todoDetails) async{
    final prefs = await preferences;
    return await getTodods().then((storedTodos) async{
      final newIndex = storedTodos.length + 1;
      await prefs.setInt(numberOfTodos, newIndex);
      final currentDateTime = DateTime.now();
      final creationDateTime = DateFormat(dateFormatString)
        .format(currentDateTime);
      todoDetails.addAll(
        [falseString, creationDateTime, '$newIndex']
      );
      return await prefs.setStringList(
        todoString+newIndex.toString(), 
        todoDetails
      );
    });
  }

  Future<bool> updateTodo(List<String> newTodo, String index) async{
    final prefs = await preferences;
    return await prefs.setStringList(todoString+index, newTodo);
  }

  Future<bool> deleteTodo(String todoToDelete) async{
    final prefs = await preferences;
    return prefs.remove(todoToDelete);
  }

  Future<List<String>?> getTodo(String index) async{
    final prefs = await preferences;
    return prefs.getStringList(todoString+index);
  }

  Future<Iterable<List<String>?>> getTodods() async{
    final prefs = await preferences;
    final totalTodos = prefs.getInt(numberOfTodos) ?? 0;
    final listOfTodos = Iterable.generate(
      totalTodos,
      (index) {
        final stringIndex = '${index + 1}';
        return prefs.getStringList(todoString+stringIndex);
      }
    )
    .where((todo) => todo != null)
    .takeWhile((todo) => todo != null);
    return listOfTodos;
  }

  Future<List<dynamic>?> pickImage() async{
    final imagePicker = ImagePicker();
    final file = await imagePicker.pickImage(
      source: ImageSource.gallery
    );
    if(file != null){
      final imageFile = File(file.path);
      final fileNameToDisplay = imageFile.path.split(slashString).last;
      return [imageFile, fileNameToDisplay];
    }
    return null;
  }

  //Save image file to local directory
  Future<void> saveImageFile(File file) async{
    final prefs = await preferences;
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
    final prefs = await preferences;
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