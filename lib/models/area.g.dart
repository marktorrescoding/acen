// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'area.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AreaAdapter extends TypeAdapter<Area> {
  @override
  final int typeId = 0;

  @override
  Area read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Area(
      areaName: fields[0] as String,
      isLeaf: fields[1] as bool,
      children: (fields[2] as List).cast<Area>(),
      climbs: (fields[3] as List).cast<Climb>(),
    );
  }

  @override
  void write(BinaryWriter writer, Area obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.areaName)
      ..writeByte(1)
      ..write(obj.isLeaf)
      ..writeByte(2)
      ..write(obj.children)
      ..writeByte(3)
      ..write(obj.climbs);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AreaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
