import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'profile_image_url') required String profileImageUrl,
  }) = _User;

  factory User.fromJson(dynamic json) => _$UserFromJson(json);
}
