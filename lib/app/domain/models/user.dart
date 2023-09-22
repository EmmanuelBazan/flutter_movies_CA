import 'dart:convert';

class UserModel {
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
}
