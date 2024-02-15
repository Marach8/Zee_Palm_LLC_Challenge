// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TodoAdapter extends TypeAdapter<Todo> {
  @override
  final int typeId = 0;

  @override
  Todo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Todo(
      todoTitle: fields[0] as String,
      todoCreationDateTime: fields[4] as String,
      todoContent: fields[2] as String,
      todoDueDateTime: fields[1] as String,
      todoIsCompleted: fields[3] as bool,
    )..todoKey = fields[5] as String;
  }

  @override
  void write(BinaryWriter writer, Todo obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.todoTitle)
      ..writeByte(1)
      ..write(obj.todoDueDateTime)
      ..writeByte(2)
      ..write(obj.todoContent)
      ..writeByte(3)
      ..write(obj.todoIsCompleted)
      ..writeByte(4)
      ..write(obj.todoCreationDateTime)
      ..writeByte(5)
      ..write(obj.todoKey);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
