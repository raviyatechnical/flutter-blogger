import 'dart:convert';
import 'package:blogger/models/author.dart';

/// [PostComments] This is PostComments Model class
class PostComments {
  final String? kind;
  final String? id;
  final String? postId;
  final String? blogId;
  final DateTime? published;
  final DateTime? updated;
  final String? selfLink;
  final String? content;

  /// This is [Author] type it have all the author parameters
  final Author? author;
  final String? error;
  PostComments(
      {this.kind,
      this.id,
      this.postId,
      this.blogId,
      this.published,
      this.updated,
      this.selfLink,
      this.content,
      this.author,
      this.error});

  /// This is will help us to create Map Data
  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (kind != null) {
      result.addAll({'kind': kind});
    }
    if (id != null) {
      result.addAll({'id': id});
    }
    if (postId != null) {
      result.addAll({'postId': postId});
    }
    if (blogId != null) {
      result.addAll({'blogId': blogId});
    }
    if (published != null) {
      result.addAll({'published': published!.millisecondsSinceEpoch});
    }
    if (updated != null) {
      result.addAll({'updated': updated!.millisecondsSinceEpoch});
    }
    if (selfLink != null) {
      result.addAll({'selfLink': selfLink});
    }
    if (content != null) {
      result.addAll({'content': content});
    }
    if (author != null) {
      result.addAll({'author': author!.toMap()});
    }

    return result;
  }

  /// This is will help us to create object from Map
  factory PostComments.fromMap(Map<String, dynamic> map) {
    return PostComments(
      kind: map['kind'],
      id: map['id'],
      postId: map['post']['id'],
      blogId: map['blog']['id'],
      published: map['published'] != null
          ? DateTime.parse(map[
              'published']) //DateTime.fromMillisecondsSinceEpoch(map['published'])
          : null,
      updated: map['updated'] != null
          ? DateTime.parse(map[
              'updated']) //DateTime.fromMillisecondsSinceEpoch(map['updated'])
          : null,
      selfLink: map['selfLink'],
      content: map['content'],
      author: map['author'] != null ? Author.fromMap(map['author']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  /// This is will help us to create object from json input
  factory PostComments.fromJson(String source) =>
      PostComments.fromMap(json.decode(source));

  PostComments copyWith({
    String? kind,
    String? id,
    String? postId,
    String? blogId,
    DateTime? published,
    DateTime? updated,
    String? selfLink,
    String? content,
    Author? author,
  }) {
    return PostComments(
      kind: kind ?? this.kind,
      id: id ?? this.id,
      postId: postId ?? this.postId,
      blogId: blogId ?? this.blogId,
      published: published ?? this.published,
      updated: updated ?? this.updated,
      selfLink: selfLink ?? this.selfLink,
      content: content ?? this.content,
      author: author ?? this.author,
    );
  }
}
