import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class CheckSignUp{
  Future<String> get dosyaYoly async {
    Directory dosyaPath = await getApplicationDocumentsDirectory();

    return dosyaPath.path;
  }
  Future<File> get dosyaOlostur async {
    var dosya = await dosyaYoly + "/myDosya.txt";
    return File(dosya);
  }

  Future<String> dosyaOku() async {
    try {
      var myDosya = await dosyaOlostur;

      String dosyaIcerik = await myDosya.readAsString();
      debugPrint(dosyaIcerik+"sdsfsa");
      return dosyaIcerik;
    } catch (exception) {
      return 'Hata Cikti $exception';
    }
  }

  Future<File> dosyaYaz(String yaz) async {
    var myDosya = await dosyaOlostur;
    return myDosya.writeAsString(yaz);
  }
}