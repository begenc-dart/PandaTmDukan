// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString?);

import 'package:meta/meta.dart';
import 'dart:convert';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String? productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    required this.id,
    required this.productId,
    required this.nameTm,
    required this.nameRu,
    required this.bodyTm,
    required this.bodyRu,
    required this.productCode,
    required this.price,
    required this.priceOld,
    required this.priceTm,
    required this.priceTmOld,
    required this.priceUsd,
    required this.priceUsdOld,
    required this.discount,
    required this.isActive,
    required this.sex,
    required this.isNew,
    required this.isAction,
    required this.rating,
    required this.ratingCount,
    required this.soldCount,
    required this.likeCount,
    required this.isNewExpire,
    required this.isLiked,
    required this.categoryId,
    required this.subcategoryId,
    required this.brandId,
    required this.sellerId,
    required this.createdAt,
    required this.updatedAt,
    required this.productColors,
    required this.productSizes,
    required this.details,
    required this.images,
    required this.category,
    required this.subcategory,
    required this.productStock
  });

  int? id;
  String? productId;
  String? nameTm;
  String? nameRu;
  String? bodyTm;
  String? bodyRu;
  dynamic productCode;
  double? price;
  double? priceOld;
  double? priceTm;
  double? priceTmOld;
  dynamic priceUsd;
  dynamic priceUsdOld;
  int? discount;
  bool? isActive;
  String? sex;
  bool? isNew;
  bool? isAction;
  int? rating;
  int? ratingCount;
  int? soldCount;
  int? likeCount;
  String? isNewExpire;
  bool? isLiked;
  int? categoryId;
  int? subcategoryId;
  dynamic brandId;
  int? sellerId;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<ProductColor>? productColors;
  List<ProductSize>? productSizes;
  List<Detail>? details;
  List<Images>? images;
  Category? category;
  Category? subcategory;
  List<ProductStock> productStock;
  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json["id"] == null ? null : json["id"],
    productId: json["product_id"] == null ? null : json["product_id"],
    nameTm: json["name_tm"] == null ? null : json["name_tm"],
    nameRu: json["name_ru"] == null ? null : json["name_ru"],
    bodyTm: json["body_tm"] == null ? null : json["body_tm"],
    bodyRu: json["body_ru"] == null ? null : json["body_ru"],
    productCode: json["product_code"],
    price: json["price"] == null ? null : json["price"].toDouble(),
    priceOld: json["price_old"] == null ? null : json["price_old"].toDouble(),
    priceTm: json["price_tm"] == null ? null : json["price_tm"].toDouble(),
    priceTmOld: json["price_tm_old"] == null ? null : json["price_tm_old"].toDouble(),
    priceUsd: json["price_usd"],
    priceUsdOld: json["price_usd_old"],
    discount: json["discount"] == null ? null : json["discount"],
    isActive: json["isActive"] == null ? null : json["isActive"],
    sex: json["sex"] == null ? null : json["sex"],
    isNew: json["isNew"] == null ? null : json["isNew"],
    isAction: json["isAction"] == null ? null : json["isAction"],
    rating: json["rating"] == null ? null : json["rating"],
    ratingCount: json["rating_count"] == null ? null : json["rating_count"],
    soldCount: json["sold_count"] == null ? null : json["sold_count"],
    likeCount: json["likeCount"] == null ? null : json["likeCount"],
    isNewExpire: json["is_new_expire"] == null ? null : json["is_new_expire"],
    isLiked: json["isLiked"] == null ? null : json["isLiked"],
    categoryId: json["categoryId"] == null ? null : json["categoryId"],
    subcategoryId: json["subcategoryId"] == null ? null : json["subcategoryId"],
    brandId: json["brandId"],
    sellerId: json["createdAt"] == null ? null : json["sellerId"],
    createdAt: json["sellerId"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt:  json["updatedAt"] == null ? null :DateTime.parse(json["updatedAt"]),
    productColors: json["product_colors"] == null ? null : List<ProductColor>.from(json["product_colors"].map((x) => ProductColor.fromJson(x))),
    productSizes: json["product_sizes"] == null ? null : List<ProductSize>.from(json["product_sizes"].map((x) => ProductSize.fromJson(x))),
    details: json["details"] == null ? null : List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
    images: json["images"] == null ? null : List<Images>.from(json["images"].map((x) => Images.fromJson(x))),
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
    subcategory: json["subcategory"] == null ? null : Category.fromJson(json["subcategory"]),
    productStock: List<ProductStock>.from(json["product_stock"].map((x) => ProductStock.fromJson(x))),

  );

  Map<String?, dynamic> toJson() => {
    "id": id == null ? null : id,
    "product_id": productId == null ? null : productId,
    "name_tm": nameTm == null ? null : nameTm,
    "name_ru": nameRu == null ? null : nameRu,
    "body_tm": bodyTm == null ? null : bodyTm,
    "body_ru": bodyRu == null ? null : bodyRu,
    "product_code": productCode,
    "price": price == null ? null : price,
    "price_old": priceOld == null ? null : priceOld,
    "price_tm": priceTm == null ? null : priceTm,
    "price_tm_old": priceTmOld == null ? null : priceTmOld,
    "price_usd": priceUsd,
    "price_usd_old": priceUsdOld,
    "discount": discount == null ? null : discount,
    "isActive": isActive == null ? null : isActive,
    "sex": sex == null ? null : sex,
    "isNew": isNew == null ? null : isNew,
    "isAction": isAction == null ? null : isAction,
    "rating": rating == null ? null : rating,
    "rating_count": ratingCount == null ? null : ratingCount,
    "sold_count": soldCount == null ? null : soldCount,
    "likeCount": likeCount == null ? null : likeCount,
    "is_new_expire": isNewExpire == null ? null : isNewExpire,
    "isLiked": isLiked == null ? null : isLiked,
    "categoryId": categoryId == null ? null : categoryId,
    "subcategoryId": subcategoryId == null ? null : subcategoryId,
    "brandId": brandId,
    "sellerId": sellerId == null ? null : sellerId,
    "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "product_colors": productColors == null ? null : List<dynamic>.from(productColors!.map((x) => x.toJson())),
    "product_sizes": productSizes == null ? null : List<dynamic>.from(productSizes!.map((x) => x.toJson())),
    "details": details == null ? null : List<dynamic>.from(details!.map((x) => x.toJson())),
    "images": images == null ? null : List<dynamic>.from(images!.map((x) => x.toJson())),
    "category": category == null ? null : category!.toJson(),
    "subcategory": subcategory == null ? null : subcategory!.toJson(),
    "product_stock": List<dynamic>.from(productStock.map((x) => x.toJson())),
  };
}

class Category {
  Category({
    required this.id,
    required this.categoryCategoryId,
    required this.nameTm,
    required this.nameRu,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.subcategoryId,
    required this.categoryId,
  });

  int? id;
  String? categoryCategoryId;
  String? nameTm;
  String? nameRu;
  String? image;
  DateTime createdAt;
  DateTime updatedAt;
  String? subcategoryId;
  int? categoryId;

  factory Category.fromJson(Map<String?, dynamic> json) => Category(
    id: json["id"] == null ? null : json["id"],
    categoryCategoryId: json["category_id"] == null ? null : json["category_id"],
    nameTm: json["name_tm"] == null ? null : json["name_tm"],
    nameRu: json["name_ru"] == null ? null : json["name_ru"],
    image: json["image"] == null ? null : json["image"],
    createdAt:  DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    subcategoryId: json["subcategory_id"] == null ? null : json["subcategory_id"],
    categoryId: json["categoryId"] == null ? null : json["categoryId"],
  );

  Map<String?, dynamic> toJson() => {
    "id": id == null ? null : id,
    "category_id": categoryCategoryId == null ? null : categoryCategoryId,
    "name_tm": nameTm == null ? null : nameTm,
    "name_ru": nameRu == null ? null : nameRu,
    "image": image == null ? null : image,
    "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
    "subcategory_id": subcategoryId == null ? null : subcategoryId,
    "categoryId": categoryId == null ? null : categoryId,
  };
}

class Detail {
  Detail({
    required this.id,
    required this.detailId,
    required this.image,
    required this.productId,
    required this.createdAt,
    required this.updatedAt,
  });

  int? id;
  String? detailId;
  String? image;
  int? productId;
  DateTime createdAt;
  DateTime updatedAt;

  factory Detail.fromJson(Map<String?, dynamic> json) => Detail(
    id: json["id"] == null ? null : json["id"],
    detailId: json["detail_id"] == null ? null : json["detail_id"],
    image: json["image"] == null ? null : json["image"],
    productId: json["productId"] == null ? null : json["productId"],
    createdAt:  DateTime.parse(json["createdAt"]),
    updatedAt:  DateTime.parse(json["updatedAt"]),
  );

  Map<String?, dynamic> toJson() => {
    "id": id == null ? null : id,
    "detail_id": detailId == null ? null : detailId,
    "image": image == null ? null : image,
    "productId": productId == null ? null : productId,
    "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
  };
}

class Images {
  Images({
    required this.id,
    required this.imageId,
    required this.productId,
    required this.image,
    required this.productcolorId,
    required this.createdAt,
    required this.updatedAt,
    required this.freeproductId,
  });

  int? id;
  String? imageId;
  int? productId;
  String? image;
  int? productcolorId;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic freeproductId;

  factory Images.fromJson(Map<String?, dynamic> json) => Images(
    id: json["id"] == null ? null : json["id"],
    imageId: json["image_id"] == null ? null : json["image_id"],
    productId: json["productId"] == null ? null : json["productId"],
    image: json["image"] == null ? null : json["image"],
    productcolorId: json["productcolorId"] == null ? null : json["productcolorId"],
    createdAt:  DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    freeproductId: json["freeproductId"],
  );

  Map<String?, dynamic> toJson() => {
    "id": id == null ? null : id,
    "image_id": imageId == null ? null : imageId,
    "productId": productId == null ? null : productId,
    "image": image == null ? null : image,
    "productcolorId": productcolorId == null ? null : productcolorId,
    "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
    "freeproductId": freeproductId,
  };
}

class ProductColor {
  ProductColor({
    required this.id,
    required this.productColorId,
    required this.productId,
    required this.colorNameTm,
    required this.colorNameRu,
    required this.createdAt,
    required this.updatedAt,
    required this.productImages,
    required this.productSizes,
  });

  int? id;
  String? productColorId;
  int? productId;
  String? colorNameTm;
  String? colorNameRu;
  DateTime createdAt;
  DateTime updatedAt;
  List<Images>? productImages;
  List<ProductSize>? productSizes;

  factory ProductColor.fromJson(Map<String?, dynamic> json) => ProductColor(
    id: json["id"] == null ? null : json["id"],
    productColorId: json["product_color_id"] == null ? null : json["product_color_id"],
    productId: json["productId"] == null ? null : json["productId"],
    colorNameTm: json["color_name_tm"] == null ? null : json["color_name_tm"],
    colorNameRu: json["color_name_ru"] == null ? null : json["color_name_ru"],
    createdAt:  DateTime.parse(json["createdAt"]),
    updatedAt:  DateTime.parse(json["updatedAt"]),
    productImages: json["product_images"] == null ? null : List<Images>.from(json["product_images"].map((x) => Images.fromJson(x))),
    productSizes: json["product_sizes"] == null ? null : List<ProductSize>.from(json["product_sizes"].map((x) => ProductSize.fromJson(x))),
  );

  Map<String?, dynamic> toJson() => {
    "id": id == null ? null : id,
    "product_color_id": productColorId == null ? null : productColorId,
    "productId": productId == null ? null : productId,
    "color_name_tm": colorNameTm == null ? null : colorNameTm,
    "color_name_ru": colorNameRu == null ? null : colorNameRu,
    "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
    "product_images": productImages == null ? null : List<dynamic>.from(productImages!.map((x) => x.toJson())),
    "product_sizes": productSizes == null ? null : List<dynamic>.from(productSizes!.map((x) => x.toJson())),
  };
}

class ProductSize {
  ProductSize({
    required this.id,
    required this.productSizeId,
    required this.productId,
    required this.productColorId,
    required this.size,
    required this.price,
    required this.priceOld,
    required this.priceTm,
    required this.priceTmOld,
    required this.priceUsd,
    required this.priceUsdOld,
    required this.discount,
    required this.createdAt,
    required this.updatedAt,
  });

  int? id;
  String? productSizeId;
  int? productId;
  int? productColorId;
  String? size;
  double? price;
  double? priceOld;
  double? priceTm;
  double? priceTmOld;
  dynamic priceUsd;
  dynamic priceUsdOld;
  int? discount;
  DateTime createdAt;
  DateTime updatedAt;

  factory ProductSize.fromJson(Map<String?, dynamic> json) => ProductSize(
    id: json["id"] == null ? null : json["id"],
    productSizeId: json["product_size_id"] == null ? null : json["product_size_id"],
    productId: json["productId"] == null ? null : json["productId"],
    productColorId: json["productColorId"] == null ? null : json["productColorId"],
    size: json["size"] == null ? null : json["size"],
    price: json["price"] == null ? null : json["price"].toDouble(),
    priceOld: json["price_old"] == null ? null : json["price_old"].toDouble(),
    priceTm: json["price_tm"] == null ? null : json["price_tm"].toDouble(),
    priceTmOld:json["price_tm_old"] == null ? null :  json["price_tm_old"].toDouble(),
    priceUsd: json["price_usd"],
    priceUsdOld: json["price_usd_old"],
    discount:json["discount"] == null ? null :  json["discount"],
    createdAt:  DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String?, dynamic> toJson() => {
    "id": id == null ? null : id,
    "product_size_id": productSizeId == null ? null : productSizeId,
    "productId": productId == null ? null : productId,
    "productColorId": productColorId == null ? null : productColorId,
    "size": size == null ? null : size,
    "price": price == null ? null : price,
    "price_old": priceOld,
    "price_tm": priceTm == null ? null : priceTm,
    "price_tm_old": priceTmOld,
    "price_usd": priceUsd,
    "price_usd_old": priceUsdOld,
    "discount": discount,
    "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
  };
}
class ProductStock {
  ProductStock({
    required this.id,
    required this.productId,
    required this.productsizeId,
    required this.quantity,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int productId;
  int? productsizeId;
  int? quantity;
  DateTime createdAt;
  DateTime updatedAt;

  factory ProductStock.fromJson(Map<String, dynamic> json) => ProductStock(
    id: json["id"],
    productId: json["productId"],
    productsizeId: json["productsizeId"]==null?0:json["productsizeId"],
    quantity: json["quantity"]==null?1:json["quantity"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "productId": productId,
    "productsizeId": productsizeId,
    "quantity": quantity,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}
