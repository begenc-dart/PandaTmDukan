import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../Database/Tokens.dart';
import '../IpAddress.dart';

class PostDiscount{
  String token="";
  Future createUser(
      String discount,) async {
    await Token().tokenDosyaOku().then((value) {
      token = value;
    });

    final response = await http.post(
        Uri.parse(
          "${IpAddress().ipAddress}/seller/products/discount",
        ),
        headers: <String, String>{
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${token}',
        },
        body: jsonEncode(
            {
              "discount":discount
            }


        ));
debugPrint(response.statusCode.toString());
debugPrint(response.body);
    if (response.statusCode == 200) {
      // ColorPhoto().uploadImage(
      //     filename,(json.decode(response.body)["product_color"]["product_color_id"]).toString(), index);

      return response.body;
    } else {
      throw Exception("faild");
    }
  }}