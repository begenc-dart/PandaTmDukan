
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
String AssetLan = '';
Future<String> get LanguageFile async {
  Directory dosyaPath = await getApplicationDocumentsDirectory();
  debugPrint(dosyaPath.path);
  return dosyaPath.path;
}

Future<File> get LanguageFileCreate async {
  var dosya = await LanguageFile + "/myLanguage.text";
  return File(dosya);
}

Future<String> LanguageFileRead() async {
  try {
    var myDosya = await LanguageFileCreate;
    String dosyaIcerik = await myDosya.readAsString();
    return dosyaIcerik;
  } catch (exception) {
    return 'Hata Cikti $exception';
  }
}

Future<File> LanguageFileWrite(String yaz) async {
  var myDosya = await LanguageFileCreate;
  return myDosya.writeAsString(yaz);
}

Future<String> LanguageCode() async {
  await LanguageFileRead().then((value) {
    AssetLan = value;
  });
  return AssetLan == 'tm'
      ? "assets/language/tk.json"
      : "assets/language/ru.json";
}
