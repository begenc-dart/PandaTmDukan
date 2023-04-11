import 'dart:convert';

import 'package:dukanlar/IpAddress.dart';
import 'package:flutter/material.dart';

import '../../Database/Tokens.dart';
import '../../Model/ProductModel.dart';
import 'package:http/http.dart' as http;
class OneProduct{
 late String token;
 ProductModel? productModel;
 String ip=IpAddress().ipAddress;
  Future<ProductModel> fetchAlbum(String productId) async {
    await Token().tokenDosyaOku().then((value) {
      token = value;
    });
debugPrint(productId);
    final response =
    await http.get(Uri.parse("$ip/seller/products/${productId}"),
      headers: <String, String>{
        "Content-Type": "application/json",
        'Authorization': 'Bearer ${token}',
      } );

    var decodedJson = json.decode(response.body);
    debugPrint(response.body);
    debugPrint(response.statusCode.toString());

    productModel = ProductModel.fromJson(decodedJson);

    return productModel!;
  }
}