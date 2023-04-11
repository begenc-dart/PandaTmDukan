
// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';




import 'package:http/http.dart' as http;

import '../../../../main.dart';
import '../Database/Tokens.dart';
import '../IpAddress.dart';

class UpdateMe{

  String? token;

  Future createUser(

      String name_tm,String name_ru,String address_tm,String address_ru,String phone_num_extra,XFile photo,BuildContext context) async {
    await Token().tokenDosyaOku().then((value) {
      token = value;
    });
    final response = await http.patch(
        Uri.parse(
          "${IpAddress().ipAddress}/seller/account",
        ),
        headers: <String, String>{
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${token}',
        },
        body: jsonEncode(<String, String>{
          "name": name_tm,
          'address_tm': address_tm,
          "address_ru":address_ru,
          "name_ru":name_ru,
          "phone_number_extra":phone_num_extra

        }));
    debugPrint(response.body);

    debugPrint(response.statusCode.toString());


    if (response.statusCode == 200) {



      return response.body;
    } else {
      return response.body;
    }
  }


}

