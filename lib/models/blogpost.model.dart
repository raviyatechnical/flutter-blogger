import 'dart:convert';

/// [BlogPage] This is BlogPage Model class
class BlogPage {
  final int totalItems;
  final String selfLink;
  BlogPage({
    required this.totalItems,
    required this.selfLink,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'totalItems': totalItems});
    result.addAll({'selfLink': selfLink});

    return result;
  }

  /// This is will help us to create object from Map
  factory BlogPage.fromMap(Map<String, dynamic> map) {
    return BlogPage(
      totalItems: map['totalItems']?.toInt() ?? 0,
      selfLink: map['selfLink'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  /// This is will help us to create object from json input
  factory BlogPage.fromJson(String source) =>
      BlogPage.fromMap(json.decode(source));
}
