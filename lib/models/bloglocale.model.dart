import 'dart:convert';

/// [BlogLocale] This is BlogLocale Model class
class BlogLocale {
  final String language;
  final String country;
  final String variant;
  BlogLocale({
    required this.language,
    required this.country,
    required this.variant,
  });

  /// This is will help us to create Map Data
  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'language': language});
    result.addAll({'country': country});
    result.addAll({'variant': variant});

    return result;
  }

  /// This is will help us to create object from Map
  factory BlogLocale.fromMap(Map<String, dynamic> map) {
    return BlogLocale(
      language: map['language'] ?? '',
      country: map['country'] ?? '',
      variant: map['variant'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  /// This is will help us to create object from json input
  factory BlogLocale.fromJson(String source) =>
      BlogLocale.fromMap(json.decode(source));
}
