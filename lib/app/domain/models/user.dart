import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  int id;
  String username;

  UserModel({
    required this.id,
    required this.username,
  });

  factory UserModel.fromJson(String str) => UserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        username: json["username"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "username": username,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        username,
      ];
}
