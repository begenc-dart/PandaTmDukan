// To parse this JSON data, do
//
//     final getMe = getMeFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ModelGetMe getMeFromJson(String str) => ModelGetMe.fromJson(json.decode(str));

String getMeToJson(ModelGetMe data) => json.encode(data.toJson());

class ModelGetMe {
  ModelGetMe({
    required this.id,
    required this.sellerId,
    required this.phoneNumber,
    required this.phoneNumberExtra,
    required this.nameTm,
    required this.nameRu,
    required this.image,
    required this.nickname,
    required this.addressTm,
    required this.addressRu,
    required this.createdAt,
    required this.updatedAt,
  });

  int? id;
  String? sellerId;
  String? phoneNumber;
  String? phoneNumberExtra;
  String? nameTm;
  String? nameRu;
  String? image;
  String? nickname;
  String? addressTm;
  String? addressRu;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory ModelGetMe.fromJson(Map<String, dynamic> json) => ModelGetMe(
    id: json["id"] == null ? null : json["id"],
    sellerId: json["seller_id"] == null ? null : json["seller_id"],
    phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
    phoneNumberExtra: json["phone_number_extra"] == null ? null : json["phone_number_extra"],
    nameTm: json["name_tm"] == null ? null : json["name_tm"],
    nameRu: json["name_ru"] == null ? null : json["name_ru"],
    image: json["image"] == null ? null : json["image"],
    nickname: json["nickname"] == null ? null : json["nickname"],
    addressTm: json["address_tm"] == null ? null : json["address_tm"],
    addressRu: json["address_ru"] == null ? null : json["address_ru"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "seller_id": sellerId == null ? null : sellerId,
    "phone_number": phoneNumber == null ? null : phoneNumber,
    "phone_number_extra": phoneNumberExtra == null ? null : phoneNumberExtra,
    "name_tm": nameTm == null ? null : nameTm,
    "name_ru": nameRu == null ? null : nameRu,
    "image": image == null ? null : image,
    "nickname": nickname == null ? null : nickname,
    "address_tm": addressTm == null ? null : addressTm,
    "address_ru": addressRu == null ? null : addressRu,
    "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
  };
}
