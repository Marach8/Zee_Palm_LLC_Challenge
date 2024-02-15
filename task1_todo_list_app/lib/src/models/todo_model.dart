import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 0)
class Todo extends HiveObject{

  @HiveField(0)
  String todoTitle;

  @HiveField(1)
  String todoDueDateTime;

  @HiveField(2)
  String todoContent;

  @HiveField(3)
  bool todoIsCompleted;

  @HiveField(4)
  String todoCreationDateTime;

  @HiveField(5)
  String todoKey;

  Todo ({
    required this.todoTitle,
    required this.todoCreationDateTime,
    required this.todoContent,
    required this.todoDueDateTime,
    required this.todoIsCompleted,
  }) : todoKey = const Uuid().v4();
}