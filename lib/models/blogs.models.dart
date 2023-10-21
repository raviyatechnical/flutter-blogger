import 'dart:convert';

import 'package:blogger/models/bloglocale.model.dart';
import 'package:blogger/models/blogpage.model.dart';
import 'package:blogger/models/blogpost.model.dart';

/// [BlogsModel] This is BlogsModel Model class
/// Here we are using [BlogPost] [BlogPage] [BlogLocale]
class BlogsModel {
  final String? kind;
  final String? id;
  final String? name;
  final String? description;
  final DateTime? published;
  final DateTime? updated;
  final String? url;
  final String? selfLink;
  final String? error;

  /// This is [BlogPost] type it have all the posts parameters
  final BlogPost? posts;

  /// This is [BlogPage] type it have all the pages parameters
  final BlogPage? pages;

  /// This is [BlogLocale] type it have all the locale parameters
  final BlogLocale? locale;
  BlogsModel({
    this.kind,
    this.id,
    this.name,
    this.description,
    this.published,
    this.updated,
    this.url,
    this.selfLink,
    this.error,
    this.posts,
    this.pages,
    this.locale,
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
    if (name != null) {
      result.addAll({'name': name});
    }
    if (description != null) {
      result.addAll({'description': description});
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
    if (error != null) {
      result.addAll({'error': error});
    }
    if (posts != null) {
      result.addAll({'posts': posts!.toMap()});
    }
    if (pages != null) {
      result.addAll({'pages': pages!.toMap()});
    }
    if (locale != null) {
      result.addAll({'locale': locale!.toMap()});
    }

    return result;
  }

  /// This is will help us to create object from Map
  factory BlogsModel.fromMap(Map<String, dynamic> map) {
    return BlogsModel(
      kind: map['kind'],
      id: map['id'],
      name: map['name'],
      description: map['description'],
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
      error: map['error'],
      posts: map['posts'] != null ? BlogPost.fromMap(map['posts']) : null,
      pages: map['pages'] != null ? BlogPage.fromMap(map['pages']) : null,
      locale: map['locale'] != null ? BlogLocale.fromMap(map['locale']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  /// This is will help us to create object from json input
  factory BlogsModel.fromJson(String source) =>
      BlogsModel.fromMap(json.decode(source));

  BlogsModel copyWith({
    String? kind,
    String? id,
    String? name,
    String? description,
    DateTime? published,
    DateTime? updated,
    String? url,
    String? selfLink,
    String? error,
    BlogPost? posts,
    BlogPage? pages,
    BlogLocale? locale,
  }) {
    return BlogsModel(
      kind: kind ?? this.kind,
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      published: published ?? this.published,
      updated: updated ?? this.updated,
      url: url ?? this.url,
      selfLink: selfLink ?? this.selfLink,
      error: error ?? this.error,
      posts: posts ?? this.posts,
      pages: pages ?? this.pages,
      locale: locale ?? this.locale,
    );
  }
}
