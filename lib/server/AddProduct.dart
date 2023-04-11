import 'dart:convert';

import 'package:dukanlar/server/AddColor.dart';
import 'package:dukanlar/server/AddDetal.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../Database/Tokens.dart';
import 'package:http/http.dart' as http;

import '../IpAddress.dart';
import '../main.dart';
import 'AddSize.dart';
import 'SendPhot.dart';

class AddProduct {
  String? token;

  Future createUser(
      String code,
      bool action,
      String stok,
      String nameTm,
      String nameRu,
      String bodyTm,
      String bodyRu,
      String price,
      String categorId,
      String subatId,
      String discount,
      String quantity,
      List<XFile> filename,
      List<XFile> detalIp,
      List color,
      List<XFile> colorPhoto,
      List sized,BuildContext context) async {
    await Token().tokenDosyaOku().then((value) {
      token = value;
    });
    final response = await http.post(
        Uri.parse(
          "${IpAddress().ipAddress}/seller/products/add",
        ),
        headers: <String, String>{
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${token}',
        },
        body: jsonEncode(<String, String>{
          "name_tm": nameTm,
          "name_ru": nameRu,
          "body_tm": bodyTm,
          "body_ru": bodyRu,
          "price": price,
          "category_id": categorId,
          "subcategory_id": subatId,
          "discount": discount,
          "quantity": quantity,
          "quantity":stok,
          "product_code":code,
          "isAction": action.toString(),
        }));

    // debugPrint(response.body);
    // debugPrint(response.statusCode.toString());
    if (response.statusCode == 201) {
      PhotoPost().uploadImage(
        filename,
        json.decode(response.body)["product_id"].toString(),
      );
      AddDetal().uploadImage(
          detalIp, json.decode(response.body)["product_id"].toString());
      for (int i = 0; i < color.length; i++) {
        AddColorAPI().createUser(color[i][0], color[i][1],
            json.decode(response.body)["product_id"].toString(),colorPhoto,i,sized);
      }

      return response.body;
    } else {
      throw Exception("faild");
    }
  }
}
