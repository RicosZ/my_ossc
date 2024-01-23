// To parse this JSON data, do
//
//     final osscUser = osscUserFromJson(jsonString);

import 'dart:convert';

OsscUser osscUserFromJson(String str) => OsscUser.fromJson(json.decode(str));

String osscUserToJson(OsscUser data) => json.encode(data.toJson());

class OsscUser {
  bool success;
  List<OsscUserData> data;

  OsscUser({
    required this.success,
    required this.data,
  });

  factory OsscUser.fromJson(Map<String, dynamic> json) => OsscUser(
        success: json["success"],
        data: List<OsscUserData>.from(
            json["data"].map((x) => OsscUserData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class OsscUserData {
  String no;
  String username;
  String password;
  String name;
  String permission;

  OsscUserData({
    required this.no,
    required this.username,
    required this.password,
    required this.name,
    required this.permission,
  });

  factory OsscUserData.fromJson(Map<String, dynamic> json) => OsscUserData(
        no: json["no"],
        username: json["username"],
        password: json["password"],
        name: json["name"],
        permission: json["permission"],
      );

  Map<String, dynamic> toJson() => {
        "no": no,
        "username": username,
        "password": password,
        "name": name,
        "permission": permission,
      };
}
