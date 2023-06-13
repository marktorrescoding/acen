import 'package:hive/hive.dart';
import 'package:openbeta/models/area.dart';
import 'package:openbeta/models/climb.dart';

class ClimbAdapter extends TypeAdapter<Climb> {
  @override
  final int typeId = 1;

  @override
  Climb read(BinaryReader reader) {
    // Read and deserialize the Climb object
    final name = reader.readString();
    final yds = reader.readString();
    final description = reader.readString();
    final location = reader.readString();
    final protection = reader.readString();

    return Climb(
      name: name,
      yds: yds,
      content: Content(
        description: description,
        location: location,
        protection: protection,
      ),
    );
  }

  @override
  void write(BinaryWriter writer, Climb obj) {
    // Serialize and write the Climb object
    writer.writeString(obj.name);
    writer.writeString(obj.yds);
    writer.writeString(obj.content.description);
    writer.writeString(obj.content.location);
    writer.writeString(obj.content.protection);
  }
}
