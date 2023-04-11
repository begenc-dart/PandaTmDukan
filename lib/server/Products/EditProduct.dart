import 'dart:convert';


import 'package:dukanlar/main.dart';
import 'package:dukanlar/server/AddColor.dart';
import 'package:dukanlar/server/AddDetal.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


import 'package:http/http.dart' as http;

import '../../Database/Tokens.dart';
import '../../IpAddress.dart';
import '../SendPhot.dart';


class EditProductHTTP {
  String? token;

  Future createUser(String nameTm,
      String nameRu,
      String bodyTm,
      String bodyRu,
      String price,
      String categorId,
      String subatId,
      String discount,
      String quantity,
      List filename,
      List<XFile> detalIp,
      List color,
      List<XFile> colorPhoto,
      List sized, String productId,bool check, BuildContext context,String barcode) async {
    await Token().tokenDosyaOku().then((value) {
      token = value;
    });
    debugPrint(quantity);
    final response = await http.patch(
        Uri.parse(
          "${IpAddress().ipAddress}/seller/products/$productId",
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
          "product_code":barcode,
          "quantity": quantity,
          "isAction": check.toString(),
          "isActive":"false"
        }));

    debugPrint(response.body);
    debugPrint(response.statusCode.toString());
    if (response.statusCode == 200) {
      PhotoPost().uploadImage(
        filename,
        json.decode(response.body)["product_id"].toString(),
      );
      AddDetal().uploadImage(
          detalIp, json.decode(response.body)["product_id"].toString());
      for (int i = 0; i < color.length; i++) {
        AddColorAPI().createUser(color[i][0], color[i][1],
            json.decode(response.body)["product_id"].toString(), colorPhoto, i,
            sized);
      }
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => MyHomePage()), (
              route) => false);
      return response.body;
    } else {
      throw Exception("faild");
    }
  }
}
