import 'dart:io';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AppBackend {
  AppBackend._sharedInstance();
  static final _shared = AppBackend._sharedInstance();
  factory AppBackend() => _shared;

  Future<SharedPreferences> get preferences async 
    => await SharedPreferences.getInstance();

  Future<void> saveUsername(String username) async{
    final pref = await preferences;
    await pref.setString('username', username);
  }

  Future<String?> getUsername(String username) async{
    final pref = await preferences;
    return pref.getString(username);
  }

  Future<File> pickImage() async{
    final imagePicker = ImagePicker();
    final file = await imagePicker.pickImage(
      source: ImageSource.gallery
    );
    return File(file!.path);
  }

  Future<void> saveToLocalDirectory(File file) async{
    final prefs = await preferences;
    final deviceDirectory = await getApplicationDocumentsDirectory();
    final fileExtension = file.path.split('.').last;
    final newFilePath = join(deviceDirectory.path, 'dp.$fileExtension');
    prefs.setString('newFilePath', newFilePath);
    await file.copy(newFilePath);
  }

  Future<Uint8List?> retrieveFromLocalDirectory() async{
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