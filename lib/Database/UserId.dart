import 'dart:io';

import 'package:path_provider/path_provider.dart';

class IdWrite{
  Future<String> get id async {
    Directory dosyaPath = await getApplicationDocumentsDirectory();

    return dosyaPath.path;
  }

  Future<File> get createId async {
    var dosya = await id + "/id.txt";
    return File(dosya);
  }

  Future<String> idread() async {
    try {
      var myDosya = await createId;
      String dosyaIcerik = await myDosya.readAsString();
      return dosyaIcerik;
    } catch (exception) {
      return 'Hata Cikti $exception';
    }
  }

  Future<File> idwrite(String yaz) async {
    var myDosya = await createId;
    return myDosya.writeAsString(yaz);
  }
}