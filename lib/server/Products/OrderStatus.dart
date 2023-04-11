import 'dart:convert';

import 'package:dukanlar/IpAddress.dart';
import 'package:dukanlar/Model/OrderHistoryStatus.dart';
import 'package:flutter/cupertino.dart';

import '../../Database/Tokens.dart';
import 'package:http/http.dart' as http;
class OrderStatus{
  late String token;
 late OrderHistory orderHistory;
  Future<OrderHistory> fetchAlbum(String ip) async {
    await Token().tokenDosyaOku().then((value) {
      token = value;
    });

    final response =
    await http.get(Uri.parse("${IpAddress().ipAddress}/seller/orders/order-products/${ip}"),
      headers: <String, String>{
        "Content-Type": "application/json",
        'Authorization': 'Bearer ${token}',
      });

    var decodedJson = json.decode(response.body);
debugPrint(response.body);

    orderHistory = OrderHistory.fromJson(decodedJson);

    return orderHistory;
  }
}