// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: (json['id'] as num?)?.toInt(),
      username: json['username'] as String,
      first_name: json['first_name'] as String,
      last_name: json['last_name'] as String,
      gender: json['gender'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      password: json['password'] as String?,
      date_of_birth: json['date_of_birth'] as String,
      profile_picture: json['profile_picture'] as String?,
      created_at: json['created_at'] as String?,
      updated_at: json['updated_at'] as String?,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'gender': instance.gender,
      'email': instance.email,
      'phone': instance.phone,
      'password': instance.password,
      'date_of_birth': instance.date_of_birth,
      'profile_picture': instance.profile_picture,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
    };
