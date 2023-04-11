// To parse this JSON data, do
//
//     final allOrderModel = allOrderModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AllOrderModel allOrderModelFromJson(String str) => AllOrderModel.fromJson(json.decode(str));

String allOrderModelToJson(AllOrderModel data) => json.encode(data.toJson());

class AllOrderModel {
  AllOrderModel({
    required this.orders,
    required this.count,
  });

  List<Order>? orders;
  int count;

  factory AllOrderModel.fromJson(Map<String, dynamic> json) => AllOrderModel(
    orders: json["orders"]==null?null: List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
    count: json["count"] == null ? null : json["count"],
  );

  Map<String, dynamic> toJson() => {
    "orders": orders == null ? null : List<dynamic>.from(orders!.map((x) => x.toJson())),
    "count": count == null ? null : count,
  };
}

class Order {
  Order({
    required this.id,
    required this.orderId,
    required this.userId,
    required this.sellerId,
    required this.totalPrice,
    required this.totalQuantity,
    required this.userName,
    required this.userPhone,
    required this.paymentType,
    required this.iTake,
    required this.address,
    required this.status,
    required this.deliveryTime,
    required this.note,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String orderId;
  int userId;
  int sellerId;
  double totalPrice;
  int totalQuantity;
  String userName;
  String userPhone;
  String paymentType;
  bool? iTake;
  String address;
  String status;
  String deliveryTime;
  dynamic note;
  DateTime createdAt;
  DateTime updatedAt;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"] == null ? null : json["id"],
    orderId: json["order_id"] == null ? null : json["order_id"],
    userId: json["userId"] == null ? null : json["userId"],
    sellerId: json["sellerId"] == null ? null : json["sellerId"],
    totalPrice: json["total_price"] == null ? null : json["total_price"].toDouble(),
    totalQuantity: json["total_quantity"] == null ? null : json["total_quantity"],
    userName: json["user_name"] == null ? null : json["user_name"],
    userPhone: json["user_phone"] == null ? null : json["user_phone"],
    paymentType: json["payment_type"] == null ? null : json["payment_type"],
    iTake: json["i_take"] == null ? null : json["i_take"],
    address: json["address"] == null ? null : json["address"],
    status: json["status"] == null ? null : json["status"],
    deliveryTime: json["delivery_time"] == null ? null : json["delivery_time"],
    note: json["note"],
    createdAt:  DateTime.parse(json["createdAt"]),
    updatedAt:  DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "order_id": orderId == null ? null : orderId,
    "userId": userId == null ? null : userId,
    "sellerId": sellerId == null ? null : sellerId,
    "total_price": totalPrice == null ? null : totalPrice,
    "total_quantity": totalQuantity == null ? null : totalQuantity,
    "user_name": userName == null ? null : userName,
    "user_phone": userPhone == null ? null : userPhone,
    "payment_type": paymentType == null ? null : paymentType,
    "i_take": iTake == null ? null : iTake,
    "address": address == null ? null : address,
    "status": status == null ? null : status,
    "delivery_time": deliveryTime == null ? null : deliveryTime,
    "note": note,
    "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
  };
}
