import 'dart:convert';

import 'package:dukanlar/Database/Language/LanguagePath.dart';
import 'package:dukanlar/Model/LanguageModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../CategorChangeNoti.dart';
class Language{
String url="";
late LanguageModel languageModel;

  Future<LanguageModel> fetchAlbum(BuildContext context) async {
    final lang = Provider.of<LanguageNot>(context);
    await LanguageFileRead().then((value) {
      url = value;
    });
    // debugPrint(url.toString());
    var giveJson = await DefaultAssetBundle.of(context).loadString(
        lang.sana == "ru" ? "asset/language/rus.json" : "asset/language/tm.json");
    var decodedJson = json.decode(giveJson);
    debugPrint(decodedJson.toString());
    languageModel = LanguageModel.fromJson(decodedJson);

    return languageModel;
  }
}