class Outfit {
  final int id;
  final String imagePath;
  final String season;
  final String color;

  Outfit({
    required this.id,
    required this.imagePath,
    required this.season,
    required this.color,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imagePath': imagePath,
      'season': season,
      'color': color,
    };
  }

  static Outfit fromMap(Map<String, dynamic> map) {
    return Outfit(
      id: map['id'],
      imagePath: map['imagePath'],
      season: map['season'],
      color: map['color'],
    );
  }
}
