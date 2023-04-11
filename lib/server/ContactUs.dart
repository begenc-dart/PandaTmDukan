import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../../main.dart';
import '../Database/Tokens.dart';
import '../IpAddress.dart';
class Contact_Us_Model{
  String? token;
  Future createUser(String name,String email,String phone,String text,BuildContext context) async {
    await Token().tokenDosyaOku().then((value) {
      token = value;
    });
    final response = await http.post(
        Uri.parse(
          "${IpAddress().ipAddress}/public/contact-us",
        ),
        headers: <String, String>{
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${token}',
        },
        body: jsonEncode(<String, String>{
          "name": name,
          "email":email,
          "phone":phone,
          "text":text,
        }));

    debugPrint(response.body);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => MyHomePage()),
          (Route<dynamic> route) => false,
    );

    return response.body;

  }
}