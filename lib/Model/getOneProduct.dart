import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../Database/Tokens.dart';
import '../IpAddress.dart';
import 'ProductsModel.dart';
class OneProduct{
  String _token="";
   ProductsMainPageModel productsMainPageModel=ProductsMainPageModel(products: [], count: 0);
  Future<ProductsMainPageModel> allProduct({bool isrefest = false}) async {
    await Token().tokenDosyaOku().then((value) {
      _token = value;
    });



    final response = await http.get(
        Uri.parse("${IpAddress().ipAddress}/seller/products?offset=10"),
        headers: <String, String>{
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${_token}',
        });

    debugPrint(response.body.toString());
    if (response.statusCode == 200) {
      productsMainPageModel = productsMainPageModelFromJson(response.body);

      return productsMainPageModel;
    } else {
      throw false;
    }

  }
}