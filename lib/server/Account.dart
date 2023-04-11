import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../Database/Tokens.dart';
import 'package:http/http.dart' as http;

import '../IpAddress.dart';
import '../main.dart';

class DukanInfo {
  String? token;

  Future createUser(
      String nameTm, String nameRu, String addressTm, String addressRu,XFile photo,BuildContext context) async {
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
          "name_tm": nameTm,
          "name_ru": nameRu,
          "address_tm": addressTm,
          "address_ru": addressRu
        }));

    debugPrint(response.body);
    debugPrint(response.statusCode.toString());
    if (response.statusCode == 200) {
      UploadSellerPhoto().uploadImage(photo);

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage()),
              (Route<dynamic> route) => false
      );
      return response.body;
    } else {
      throw Exception("faild");
    }
  }
}

class UploadSellerPhoto {
  String? token;

  Future<String?> uploadImage(XFile filename, ) async {
    await Token().tokenDosyaOku().then((value) {
      token = value;
    });
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            "${IpAddress().ipAddress}/seller/account/upload-image"));
    request.headers.addAll({
      "Content-Type": "application/json",
      'Authorization': 'Bearer ${token}',
    });
    debugPrint(filename.toString());

    debugPrint(filename.toString());
    request.files
        .add(await http.MultipartFile.fromPath('color', filename.path));

    var res = await request.send();
    final respStr = await res.stream.bytesToString();
    debugPrint(respStr.toString());
    debugPrint(res.statusCode.toString());
    return res.reasonPhrase;
  }
}