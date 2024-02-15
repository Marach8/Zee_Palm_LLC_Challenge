import 'package:hive/hive.dart';

class Todo extends HiveObject{
  @HiveField(0)
  String? todoKey;

  @HiveField(1)
  String? todoTitle;

  @HiveField(2)
  String? todoDueDateTime;

  @HiveField(3)
  String? todoContent;

  @HiveField(4)
  String? todoIsCompleted;

  @HiveField(5)
  String? todoCreationDateTime;
}