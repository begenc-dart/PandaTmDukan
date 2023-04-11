
import 'dart:convert';

import 'package:dukanlar/views/Toast.dart';
import 'package:flutter/material.dart';


import '../../../main.dart';
import 'package:http/http.dart' as http;

import '../Database/Check.dart';
import '../Database/UserId.dart';
import '../IpAddress.dart';
import '../Database/Tokens.dart';
class PostLogIn{

  Future createUser(
      String phone,String pas,BuildContext context) async {
    debugPrint("fdsf");
    debugPrint(pas+" "+phone);
    var response = await http.post(
        Uri.parse(
          "${IpAddress().ipAddress}/seller/login",
        ),
        headers: <String, String>{
          "Content-Type": "application/json",
        },
        body: jsonEncode(<String, String>{
          "phone_number":phone,
          "password":pas
        }));
    debugPrint(response.body);
    debugPrint(response.statusCode.toString());


    if (response.statusCode == 200) {

      Token().tokenDosyaYaz(json.decode(response.body)['token']);
      IdWrite().idwrite(json.decode(response.body)['data']['seller']['seller_id'].toString());
      CheckSignUp().dosyaYaz(true.toString());
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
            (Route<dynamic> route) => false,
      );


      return response.body;
    } else {
      Toast().showToastDelet(context, "Siz maglumaty yanys girizdiniz");
      return response.body;
    }
  }
}