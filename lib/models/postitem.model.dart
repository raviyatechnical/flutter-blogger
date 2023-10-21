import 'dart:convert';
import 'package:blogger/models/author.dart';
import 'package:blogger/models/replies.dart';

/// [PostItemModel] This is PostItemModel Model class
class PostItemModel {
  final String? kind;
  final String? id;
  final String? blogId;
  final DateTime? published;
  final DateTime? updated;
  final String? url;
  final String? selfLink;
  final String? title;
  final String? content;

  /// This is [Author] type it have all the author parameters
  final Author? author;

  /// This is [Replies] type it have all the replies parameters
  final Replies? replies;
  final String? etag;
  final List<String>? labels;
  final String? error;
  PostItemModel({
    this.kind,
    this.id,
    this.blogId,
    this.published,
    this.updated,
    this.url,
    this.error,
    this.selfLink,
    this.title,
    this.content,
    this.author,
    this.replies,
    this.etag,
    this.labels,
  });

  /// This is will help us to create Map Data
  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (kind != null) {
      result.addAll({'kind': kind});
    }
    if (id != null) {
      result.addAll({'id': id});
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
    if (url != null) {
      result.addAll({'url': url});
    }
    if (selfLink != null) {
      result.addAll({'selfLink': selfLink});
    }
    if (title != null) {
      result.addAll({'title': title});
    }
    if (content != null) {
      result.addAll({'content': content});
    }
    if (author != null) {
      result.addAll({'author': author!.toMap()});
    }
    if (replies != null) {
      result.addAll({'replies': replies!.toMap()});
    }
    if (etag != null) {
      result.addAll({'etag': etag});
    }
    if (labels != null) {
      result.addAll({'labels': labels});
    }

    return result;
  }

  /// This is will help us to create object from Map
  factory PostItemModel.fromMap(Map<String, dynamic> map) {
    return PostItemModel(
      kind: map['kind'],
      id: map['id'],
      blogId: map['blog']['id'],
      published: map['published'] != null
          ? DateTime.parse(map[
              'published']) //DateTime.fromMillisecondsSinceEpoch(map['published'])
          : null,
      updated: map['updated'] != null
          ? DateTime.parse(map[
              'updated']) //DateTime.fromMillisecondsSinceEpoch(map['updated'])
          : null,
      url: map['url'],
      selfLink: map['selfLink'],
      title: map['title'],
      content: map['content'],
      author: map['author'] != null ? Author.fromMap(map['author']) : null,
      replies: map['replies'] != null ? Replies.fromMap(map['replies']) : null,
      etag: map['etag'],
      labels: map['labels'] != null ? List<String>.from(map['labels']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  /// This is will help us to create object from json input
  factory PostItemModel.fromJson(String source) =>
      PostItemModel.fromMap(json.decode(source));

  PostItemModel copyWith({
    String? kind,
    String? id,
    String? blogId,
    DateTime? published,
    DateTime? updated,
    String? url,
    String? selfLink,
    String? title,
    String? content,
    Author? author,
    Replies? replies,
    String? etag,
    List<String>? labels,
  }) {
    return PostItemModel(
      kind: kind ?? this.kind,
      id: id ?? this.id,
      blogId: blogId ?? this.blogId,
      published: published ?? this.published,
      updated: updated ?? this.updated,
      url: url ?? this.url,
      selfLink: selfLink ?? this.selfLink,
      title: title ?? this.title,
      content: content ?? this.content,
      author: author ?? this.author,
      replies: replies ?? this.replies,
      etag: etag ?? this.etag,
      labels: labels ?? this.labels,
    );
  }
}
