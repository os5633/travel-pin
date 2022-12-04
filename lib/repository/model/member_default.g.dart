// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_default.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberDefault _$MemberDefaultFromJson(Map<String, dynamic> json) =>
    MemberDefault(
      id: json['id'] as String,
      email: json['email'] as String?,
      name: json['name'] as String?,
      photoUrl: json['photoUrl'] as String?,
    );

Map<String, dynamic> _$MemberDefaultToJson(MemberDefault instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'photoUrl': instance.photoUrl,
    };
