class Leader {
  final int position;
  final String name;
  final int points;
  final String category;

  Leader({
    required this.position,
    required this.name,
    required this.points,
    required this.category,
  });

  factory Leader.fromJson(Map<String, dynamic> json) {
    return Leader(
      position: json['position'] as int,
      name: json['name'] as String,
      points: json['points'] as int,
      category: json['category'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'position': position,
      'name': name,
      'points': points,
      'category': category,
    };
  }

  Leader copyWith({
    int? position,
    String? name,
    int? points,
    String? category,
  }) {
    return Leader(
      position: position ?? this.position,
      name: name ?? this.name,
      points: points ?? this.points,
      category: category ?? this.category,
    );
  }
}