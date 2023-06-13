import 'package:hive/hive.dart';
import 'package:openbeta/models/area.dart';
import 'package:openbeta/models/climb.dart';

class AreaAdapter extends TypeAdapter<Area> {
  @override
  final int typeId = 0;

  @override
  Area read(BinaryReader reader) {
    // Read and deserialize the Area object
    final areaName = reader.readString();
    final isLeaf = reader.readBool();
    final childrenLength = reader.readInt();
    final List<Area> children = [];
    for (var i = 0; i < childrenLength; i++) {
      final child = reader.read() as Area?;
      if (child != null) {
        children.add(child);
      }
    }

    return Area(areaName: areaName, isLeaf: isLeaf, children: children);
  }

  @override
  void write(BinaryWriter writer, Area obj) {
    // Serialize and write the Area object
    writer.writeString(obj.areaName);
    writer.writeBool(obj.isLeaf);
    writer.writeInt(obj.children.length);
    for (var child in obj.children) {
      writer.write(child);
    }
  }
}

