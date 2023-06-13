class Climb {
  final String name;
  final String yds;
  final ClimbContent content;

  Climb({required this.name, required this.yds, required this.content});

  factory Climb.fromMap(Map<String, dynamic> map) {
    return Climb(
      name: map['name'],
      yds: map['yds'],
      content: ClimbContent.fromMap(map['content']),
    );
  }
}

class ClimbContent {
  final String description;
  final String location;
  final String protection;

  ClimbContent({required this.description, required this.location, required this.protection});

  factory ClimbContent.fromMap(Map<String, dynamic> map) {
    return ClimbContent(
      description: map['description'],
      location: map['location'],
      protection: map['protection'],
    );
  }
}
