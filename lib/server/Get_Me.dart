import 'dart:convert';

import 'package:dukanlar/Database/Check.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../Database/Tokens.dart';
import '../IpAddress.dart';
import '../Model/GetMeModel.dart';


class PostGetMe {
  String checkLike = "";
  String? token;
  String ip = IpAddress().ipAddress;
  late ModelGetMe modelGetMe;
  CheckSignUp checkSignUp = new CheckSignUp();

  Future<ModelGetMe> fetchAlbum() async {
    await Token().tokenDosyaOku().then((value) {
      token = value;
    });
    await checkSignUp.dosyaOku().then((value) {
      checkLike = value;
    });
    final response = await http
        .get(Uri.parse("${ip}/seller/account/my-account"), headers: <String, String>{
      "Content-Type": "application/json",
      'Authorization': 'Bearer ${token}',
    });

    var decodedJson = json.decode(response.body);
    modelGetMe = ModelGetMe.fromJson(decodedJson);
    debugPrint(response.body);
    return modelGetMe;
  }
}
