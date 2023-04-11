import 'dart:convert';

import 'package:dukanlar/server/ColorPhoto.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../Database/Tokens.dart';
import 'package:http/http.dart' as http;

import '../IpAddress.dart';
import 'SendPhot.dart';

class AddSize {
  String? token;
String? colorId;
  Future createUser(
      Map price,String product_id,String colorId) async {
    await Token().tokenDosyaOku().then((value) {
      token = value;
    });
    debugPrint(product_id);
    final response = await http.post(
        Uri.parse(
          "${IpAddress().ipAddress}/seller/products/add/size/to-color/${colorId}",
        ),
        headers: <String, String>{
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${token}',
        },
        body: jsonEncode(
          {
            "sizes":price["sizes"],
            "product_id":product_id
          }


        ));
debugPrint(response.body);
    debugPrint(price.toString());
debugPrint(response.statusCode.toString());
    if (response.statusCode == 201) {
      // ColorPhoto().uploadImage(
      //     filename,(json.decode(response.body)["product_color"]["product_color_id"]).toString(), index);

      return response.body;
    } else {
      throw Exception("faild");
    }
  }
}
