import 'dart:io';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AppBackend {
  AppBackend._sharedInstance();
  static final AppBackend _shared = AppBackend._sharedInstance();
  factory AppBackend() => _shared;

  Future<SharedPreferences> get preferences async 
    => await SharedPreferences.getInstance();

  Future<bool> setUsername(String username) async{
    final prefs = await preferences;
    return await prefs.setString('username', username);
  }

  Future<String?>? getUsername(String username) async{
    final prefs = await preferences;
    return prefs.getString(username);
  }

  Future<bool> setTodo(List<String> todoDetails) async{
    final prefs = await preferences;
    return await getTodods().then((storedTodos) async{
      final newIndex = storedTodos.length + 1;
      final currentDateTime = DateTime.now();
      final creationDateTime = DateFormat('yyyy-MMM-dd, hh:MM a')
        .format(currentDateTime);
      todoDetails.addAll(['false', creationDateTime, '$newIndex']);
      return await prefs.setStringList('Todo$newIndex', todoDetails);
    });
  }

  Future<bool> updateTodo(List<String> newTodo, String index) async{
    final prefs = await preferences;
    return await prefs.setStringList('Todo$index', newTodo);
  }

  Future<bool> deleteTodo(String todoToDelete) async{
    final prefs = await preferences;
    return prefs.remove(todoToDelete);
  }

  Future<List<String>?> getTodo(String index) async{
    final prefs = await preferences;
    return prefs.getStringList('Todo$index');
  }

  Future<Iterable<List<String>?>> getTodods() async{
    final prefs = await preferences;
    final listOfTodos = Iterable.generate(
      1000000,
      (index) => prefs.getStringList('Todo${index + 1}')
    ).takeWhile((todo) => todo != null);
    return listOfTodos;
  }

  Future<List<dynamic>?> pickImage() async{
    final imagePicker = ImagePicker();
    final file = await imagePicker.pickImage(
      source: ImageSource.gallery
    );
    if(file != null){
      final imageFile = File(file.path);
      final fileNameToDisplay = imageFile.path.split('/').last;
      return [imageFile, fileNameToDisplay];
    }
    return null;
  }

  //Save image file to local directory
  Future<void> saveImageFile(File file) async{
    final prefs = await preferences;
    final appDocDirectory = await getApplicationDocumentsDirectory();
    final fileExtension = file.path.split('.').last;
    final newFilePath = join(appDocDirectory.path, 'dp.$fileExtension');
    await prefs.setString('newFilePath', newFilePath);
    await file.copy(newFilePath);
  }

  //Retrieve image data from local directory
  Future<Uint8List?> retrieveImageData() async{
    final prefs = await preferences;
    final newFilePath = prefs.getString('newFilePath');
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