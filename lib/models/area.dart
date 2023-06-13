import 'package:hive/hive.dart';
import 'package:openbeta/models/climb.dart';
part 'area.g.dart';

@HiveType(typeId: 0)
class Area {
  @HiveField(0)
  final String areaName;

  @HiveField(1)
  final bool isLeaf;

  @HiveField(2)
  final List<Area> children;

  @HiveField(3)
  final List<Climb> climbs;  // Add this

  Area({
    required this.areaName,
    required this.isLeaf,
    required this.children,
    required this.climbs,  // Add this
  });

  factory Area.fromMap(Map<String, dynamic> map) {
    final areaName = map['areaName'] as String;
    final isLeaf = map['metadata']['leaf'] as bool;

    List<Area> children = [];
    if (map['children'] != null) {
      final childrenData = List<Map<String, dynamic>>.from(map['children'] as List);
      children = childrenData.map((data) => Area.fromMap(data)).toList();
    }

    // Add this block
    List<Climb> climbs = [];
    if (map['climbs'] != null) {
      final climbsData = List<Map<String, dynamic>>.from(map['climbs'] as List);
      climbs = climbsData.map((data) => Climb.fromMap(data)).toList();
    }

    return Area(areaName: areaName, isLeaf: isLeaf, children: children, climbs: climbs);  // Add climbs here
  }
}
