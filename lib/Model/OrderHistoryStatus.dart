// To parse this JSON data, do
//
//     final orderHistory = orderHistoryFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

OrderHistory orderHistoryFromJson(String str) => OrderHistory.fromJson(json.decode(str));

String orderHistoryToJson(OrderHistory data) => json.encode(data.toJson());

class OrderHistory {
  OrderHistory({
    required this.orderProducts,
  });

  List<OrderProduct>? orderProducts;

  factory OrderHistory.fromJson(Map<String, dynamic> json) => OrderHistory(
    orderProducts: json["orderProducts"] == null ? null : List<OrderProduct>.from(json["orderProducts"].map((x) => OrderProduct.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "orderProducts": orderProducts == null ? null : List<dynamic>.from(orderProducts!.map((x) => x.toJson())),
  };
}

class OrderProduct {
  OrderProduct({
    required this.productId,
    required this.nameTm,
    required this.nameRu,
    required this.image,
    required this.quantity,
    required this.price,
    required this.totalPrice,
  });

  String productId;
  String nameTm;
  String nameRu;
  String image;
  int quantity;
  int price;
  int totalPrice;

  factory OrderProduct.fromJson(Map<String, dynamic> json) => OrderProduct(
    productId: json["product_id"] == null ? null : json["product_id"],
    nameTm: json["name_tm"] == null ? null : json["name_tm"],
    nameRu: json["name_ru"] == null ? null : json["name_ru"],
    image: json["image"] == null ? null : json["image"],
    quantity: json["quantity"] == null ? null : json["quantity"],
    price: json["price"] == null ? null : json["price"],
    totalPrice: json["total_price"] == null ? null : json["total_price"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId == null ? null : productId,
    "name_tm": nameTm == null ? null : nameTm,
    "name_ru": nameRu == null ? null : nameRu,
    "image": image == null ? null : image,
    "quantity": quantity == null ? null : quantity,
    "price": price == null ? null : price,
    "total_price": totalPrice == null ? null : totalPrice,
  };
}
