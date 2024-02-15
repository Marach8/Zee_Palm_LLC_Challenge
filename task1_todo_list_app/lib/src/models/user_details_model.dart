import 'dart:typed_data';
import 'package:hive/hive.dart';
part 'user_details_model.g.dart';


@HiveType(typeId: 1)
class UserDetails extends HiveObject{

  @HiveField(0)
  String? username;

  @HiveField(1)
  Uint8List? imageData;

  @HiveField(2)
  bool userExists;

  UserDetails({
    this.username,
    this.imageData,
    required this.userExists
  });
}