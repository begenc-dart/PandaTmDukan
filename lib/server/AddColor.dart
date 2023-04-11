import 'dart:convert';

import 'package:dukanlar/server/ColorPhoto.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../Database/Tokens.dart';
import 'package:http/http.dart' as http;

import '../IpAddress.dart';
import 'AddSize.dart';
import 'SendPhot.dart';

class AddColorAPI {
  String? token;

  Future createUser(
      String color_nam_tm,String color_name_ru,String product_id,List<XFile> filename,int index,List sized,) async {
    await Token().tokenDosyaOku().then((value) {
      token = value;
    });
    final response = await http.post(
        Uri.parse(
          "${IpAddress().ipAddress}/seller/products/add/color/$product_id",
        ),
        headers: <String, String>{
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${token}',
        },
        body: jsonEncode(<String, String>{
          "color_name_tm": color_nam_tm,
          "color_name_ru": color_name_ru,

        }));

    debugPrint(response.body);

    if (response.statusCode == 201) {
      ColorPhoto().uploadImage(
        filename,(json.decode(response.body)["product_color"]["product_color_id"]).toString(), index);
      AddSize().createUser(sized[index],  product_id,json.decode(response.body)["product_color"]["product_color_id"]).toString();
      return response.body;
    } else {
      throw Exception("faild");
    }
  }
}

class PatchColor {
  String? token;

  Future createUser(
      String color_nam_tm,String color_name_ru,String product_id,XFile filename,int index,List sized,) async {
    await Token().tokenDosyaOku().then((value) {
      token = value;
    });
    final response = await http.patch(
        Uri.parse(
          "${IpAddress().ipAddress}/seller/products/color/$product_id",
        ),
        headers: <String, String>{
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${token}',
        },
        body: jsonEncode(<String, String>{
          "color_name_tm": color_nam_tm,
          "color_name_ru": color_name_ru,

        }));

    debugPrint(response.body);

    if (response.statusCode == 201) {
      // ColorPhoto().uploadImage(
      //     filename,(json.decode(response.body)["product_color"]["product_color_id"]).toString(), index);
      // AddSize().createUser(sized[index],  product_id,json.decode(response.body)["product_color"]["product_color_id"]).toString();
      return response.body;
    } else {
      throw Exception("faild");
    }
  }
}
