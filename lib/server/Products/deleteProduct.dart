import 'dart:convert';

import 'package:dukanlar/IpAddress.dart';
import 'package:flutter/material.dart';

import '../../Database/Tokens.dart';
import '../../Model/ProductModel.dart';
import 'package:http/http.dart' as http;
class DeletePhoto{
  late String token;

  String ip=IpAddress().ipAddress;
  Future fetchAlbum(String productId) async {
    await Token().tokenDosyaOku().then((value) {
      token = value;
    });
debugPrint(token);
    final response = await http.post(Uri.parse("$ip/seller/products/delete/image/${productId}"),
        headers: <String, String>{
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${token}',
        } );

debugPrint(response.body);
    return response.body;
  }
}
class DeleteColor{
  late String token;

  String ip=IpAddress().ipAddress;
  Future fetchAlbum(String productId) async {
    await Token().tokenDosyaOku().then((value) {
      token = value;
    });
    debugPrint(token);
    final response = await http.post(Uri.parse("$ip/seller/products/delete/color/${productId}"),
        headers: <String, String>{
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${token}',
        } );

    debugPrint(response.body);
    return response.body;
  }
}

class DeleteDetals{
  late String token;

  String ip=IpAddress().ipAddress;
  Future fetchAlbum(String productId) async {
    await Token().tokenDosyaOku().then((value) {
      token = value;
    });

    final response =
    await http.post(Uri.parse("$ip/seller/products/delete/detail/${productId}"),
        headers: <String, String>{
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${token}',
        } );


    return response.body;
  }
}class DeleteProduct{
  late String token;

  String ip=IpAddress().ipAddress;
  Future fetchAlbum(String productId) async {
    await Token().tokenDosyaOku().then((value) {
      token = value;
    });

    final  http.Response response = await http.post(Uri.parse("$ip/seller/products/delete/${productId}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${token}',
        } );
    debugPrint(response.body.toString());
    debugPrint(token);

    return response.body;
  }
}