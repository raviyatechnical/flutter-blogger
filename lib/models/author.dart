import 'dart:convert';

/// [Author] This is Author Model class
/// this model have [id] [displayname] [url] [imageUrl]
class Author {
  final String? id;
  final String? displayName;
  final String? url;
  final String? image;
  Author({
    this.id,
    this.displayName,
    this.url,
    this.image,
  });

  /// This is will help us to create Map Data
  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (displayName != null) {
      result.addAll({'displayName': displayName});
    }
    if (url != null) {
      result.addAll({'url': url});
    }
    if (image != null) {
      result.addAll({'image': image});
    }

    return result;
  }

  /// This is will help us to create object from Map
  factory Author.fromMap(Map<String, dynamic> map) {
    return Author(
      id: map['id'],
      displayName: map['displayName'],
      url: map['url'],
      image: map['image']['url'].toString().replaceFirst('//', ''),
    );
  }

  String toJson() => json.encode(toMap());

  /// This is will help us to create object from json input
  factory Author.fromJson(String source) => Author.fromMap(json.decode(source));

  Author copyWith({
    String? id,
    String? displayName,
    String? url,
    String? image,
  }) {
    return Author(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      url: url ?? this.url,
      image: image ?? this.image,
    );
  }
}
