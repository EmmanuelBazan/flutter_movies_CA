import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class UserModel extends Equatable {
  final int id;
  final String username;

  const UserModel({
    required this.id,
    required this.username,
  });

  factory UserModel.fromJson(String str) => UserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserModel.fromMap(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toMap() => _$UserModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        username,
      ];
}
