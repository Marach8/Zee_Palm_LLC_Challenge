import 'package:image_picker/image_picker.dart';
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

  Future<String?> pickImage() async{
    final imagePicker = ImagePicker();
    final file = await imagePicker.pickImage(
      source: ImageSource.gallery
    );
    return await file?.readAsString();
  }
}