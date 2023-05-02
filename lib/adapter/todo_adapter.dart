import 'package:hive/hive.dart';
import 'package:hivedb_app/adapter/Todo.dart';

class TodoAdapter extends TypeAdapter<Todo> {
  @override
  final typeId = 1;

  @override
  Todo read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Todo(
      title: fields[0],
      description: fields[1],
    );
  }

  @override
  void write(BinaryWriter writer, Todo obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description);
  }
}
