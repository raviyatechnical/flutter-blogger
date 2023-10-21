import 'dart:convert';
import 'package:blogger/models/postcomments.dart';

/// [Replies] This is Replies Model class
class Replies {
  final int? totalItems;
  final String? selfLink;
  final List<PostComments>? postComments;
  Replies({
    this.totalItems,
    this.selfLink,
    this.postComments,
  });

  /// This is will help us to create Map Data
  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (totalItems != null) {
      result.addAll({'totalItems': totalItems});
    }
    if (selfLink != null) {
      result.addAll({'selfLink': selfLink});
    }
    if (postComments != null) {
      result.addAll(
          {'postComments': postComments!.map((x) => x.toMap()).toList()});
    }

    return result;
  }

  /// This is will help us to create object from Map
  factory Replies.fromMap(Map<String, dynamic> map) {
    return Replies(
      totalItems: int.parse(map['totalItems']), // map['totalItems']?.toInt(),
      selfLink: map['selfLink'],
      postComments: map['postComments'] != null
          ? List<PostComments>.from(
              map['postComments']?.map((x) => PostComments.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  /// This is will help us to create object from json input
  factory Replies.fromJson(String source) =>
      Replies.fromMap(json.decode(source));

  Replies copyWith({
    int? totalItems,
    String? selfLink,
    List<PostComments>? postComments,
  }) {
    return Replies(
      totalItems: totalItems ?? this.totalItems,
      selfLink: selfLink ?? this.selfLink,
      postComments: postComments ?? this.postComments,
    );
  }
}
