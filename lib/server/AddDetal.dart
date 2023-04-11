import 'dart:io';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../Database/Tokens.dart';
import 'package:http/http.dart' as http;

import '../IpAddress.dart';

class AddDetal {
  String? token;

  Future<String?> uploadImage(List<XFile> filename, String url) async {
    await Token().tokenDosyaOku().then((value) {
      token = value;
    });
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            "${IpAddress().ipAddress}/seller/products/upload-details/$url"));
    request.headers.addAll({
      "Content-Type": "application/json",
      'Authorization': 'Bearer ${token}',
    });
    for(var i in filename){
      request.files
          .add(await http.MultipartFile.fromPath('picture', i.path));
    }
    var res = await request.send();
    final respStr = await res.stream.bytesToString();
    // debugPrint(res.statusCode.toString()+"dsfd");
    // debugPrint(respStr.toString());
    return res.reasonPhrase;
  }
}
