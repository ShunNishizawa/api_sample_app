import 'package:api_sample_app/models/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'article.freezed.dart';
part 'article.g.dart';

@freezed
class Article with _$Article {
  const factory Article({
    @JsonKey(name: 'title') required String title,
    @JsonKey(name: 'user') required User user,
    @JsonKey(name: 'likes_count') @Default(0) int likesCount,
    @JsonKey(name: 'tags') @Default([]) List<String> tags,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'url') required String url,
  }) = _Article;

  factory Article.fromJson(dynamic json) => _$ArticleFromJson(json);
}
