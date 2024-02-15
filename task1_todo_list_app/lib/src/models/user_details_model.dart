import 'package:hive/hive.dart';

class UserDetails extends HiveObject{
  @HiveField(0)
  String? username;

  @HiveField(1)
  String? imageFilePath;
}