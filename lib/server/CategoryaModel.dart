import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../IpAddress.dart';
import '../Model/CategoriyaQT.dart';
Future<List<CategoriyaModel>> caregoriyaAlbum() async {
  final response =
  await http.get(Uri.parse("${IpAddress().ipAddress}/public/categories"));
debugPrint(response.body);
debugPrint(response.statusCode.toString());
  if (response.statusCode == 200) {
    List<CategoriyaModel> a = (json.decode(response.body) as List)
        .map((e) => CategoriyaModel.fromJson(e))
        .toList();

    return a;
  } else {
    throw Exception('Failed to load album');
  }
}