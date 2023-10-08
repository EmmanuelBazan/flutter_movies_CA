import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class UserModel extends Equatable {
  final int id;
  final String username;
  final String? avatarPath;

  const UserModel({
    required this.id,
    required this.username,
    required this.avatarPath,
  });

  factory UserModel.fromJson(String str) => UserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  // factory UserModel.fromMap(Map<String, dynamic> json) =>
  //     _$UserModelFromJson(json);
  factory UserModel.fromMap(Map<String, dynamic> json) {
    final avatarPath = json['avatar']['tmdb']?['avatar_path'] as String?;

    return UserModel(
      id: json['id'] as int,
      username: json['username'] as String,
      avatarPath: avatarPath,
    );
  }

  Map<String, dynamic> toMap() => _$UserModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        username,
      ];
}
