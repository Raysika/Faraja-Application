import 'package:freezed_annotation/freezed_annotation.dart';
part 'user.freezed.dart';
part 'user.g.dart';

@Freezed()
class User with _$User{
  const factory User({
    int? id, 
    required String username,
    required String first_name,
    required String last_name,
    String? gender,
    String? email,
    String? phone,
    String? password,
    required String date_of_birth,
    String? profile_picture, 
    String? created_at,
    String? updated_at,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json)
    => _$UserFromJson(json);
}
