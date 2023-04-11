// To parse this JSON data, do
//
//     final categoriyaModel = categoriyaModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<CategoriyaModel> categoriyaModelFromJson(String str) => List<CategoriyaModel>.from(json.decode(str).map((x) => CategoriyaModel.fromJson(x)));

String categoriyaModelToJson(List<CategoriyaModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoriyaModel {
  CategoriyaModel({
    required this.id,
    required this.categoryId,
    required this.nameTm,
    required this.nameRu,
    required this.createdAt,
    required this.updatedAt,
    required this.subcategories,
  });

  int id;
  String categoryId;
  String nameTm;
  String nameRu;
  DateTime createdAt;
  DateTime updatedAt;
  List<Subcategory>? subcategories;

  factory CategoriyaModel.fromJson(Map<String, dynamic> json) => CategoriyaModel(
    id: json["id"] == null ? null : json["id"],
    categoryId: json["category_id"] == null ? null : json["category_id"],
    nameTm: json["name_tm"] == null ? null : json["name_tm"],
    nameRu: json["name_ru"] == null ? null : json["name_ru"],
    createdAt:  DateTime.parse(json["createdAt"]),
    updatedAt:  DateTime.parse(json["updatedAt"]),
    subcategories: json["subcategories"] == null ? null : List<Subcategory>.from(json["subcategories"].map((x) => Subcategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "category_id": categoryId == null ? null : categoryId,
    "name_tm": nameTm == null ? null : nameTm,
    "name_ru": nameRu == null ? null : nameRu,
    "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
    "subcategories": subcategories == null ? null : List<dynamic>.from(subcategories!.map((x) => x.toJson())),
  };
}

class Subcategory {
  Subcategory({
    required this.id,
    required this.subcategoryId,
    required this.nameTm,
    required this.nameRu,
    required this.image,
    required this.categoryId,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String subcategoryId;
  String nameTm;
  String nameRu;
  String? image;
  int categoryId;
  DateTime createdAt;
  DateTime updatedAt;

  factory Subcategory.fromJson(Map<String, dynamic> json) => Subcategory(
    id: json["id"] == null ? null : json["id"],
    subcategoryId: json["subcategory_id"] == null ? null : json["subcategory_id"],
    nameTm: json["name_tm"] == null ? null : json["name_tm"],
    nameRu: json["name_ru"] == null ? null : json["name_ru"],
    image: json["image"] == null ? null : json["image"],
    categoryId: json["categoryId"] == null ? null : json["categoryId"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt:  DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "subcategory_id": subcategoryId == null ? null : subcategoryId,
    "name_tm": nameTm == null ? null : nameTm,
    "name_ru": nameRu == null ? null : nameRu,
    "image": image == null ? null : image,
    "categoryId": categoryId == null ? null : categoryId,
    "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
  };
}
