// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'dart:convert';

List<District> districtFromJson(List<dynamic> data) =>
    List<District>.from(data.map((x) => District.fromJson(x)));

String districtToJson(List<District> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class District {
  final int? id;
  final String? nameTh;
  final String? nameEn;
  final int? provinceId;

  District({
    this.id,
    this.nameTh,
    this.nameEn,
    this.provinceId,
  });

  factory District.fromJson(Map<String, dynamic> json) => District(
        id: json["id"],
        nameTh: json["name_th"],
        nameEn: json["name_en"],
        provinceId: json["province_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name_th": nameTh,
        "name_en": nameEn,
        "province_id": provinceId,
      };
}
