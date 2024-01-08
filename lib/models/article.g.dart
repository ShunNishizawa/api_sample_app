// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ArticleImpl _$$ArticleImplFromJson(Map<String, dynamic> json) =>
    _$ArticleImpl(
      title: json['title'] as String,
      user: User.fromJson(json['user']),
      likesCount: json['likes_count'] as int? ?? 0,
      tags: List<String>.from(json['tags'].map((tag) => tag['name'])),
      createdAt: DateTime.parse(json['created_at'] as String),
      url: json['url'] as String,
    );

Map<String, dynamic> _$$ArticleImplToJson(_$ArticleImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'user': instance.user,
      'likes_count': instance.likesCount,
      'tags': instance.tags,
      'created_at': instance.createdAt.toIso8601String(),
      'url': instance.url,
    };
