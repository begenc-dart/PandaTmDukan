import 'dart:io';

import 'package:async/async.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../Database/Tokens.dart';
import 'package:http/http.dart' as http;

import '../IpAddress.dart';
import '../main.dart';
import '../views/ExcelFile/Excel_file_gos.dart';

class ColorPhoto {
  String? token;

  Future<String?> uploadImage(List<XFile> filename, String url,int index) async {
    await Token().tokenDosyaOku().then((value) {
      token = value;
    });
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            "${IpAddress().ipAddress}/seller/products/upload-image/by-color/$url"));
    request.headers.addAll({
      "Content-Type": "application/json",
      'Authorization': 'Bearer ${token}',
    });
    debugPrint(filename.toString()+"sdfsd");


      request.files
          .add(await http.MultipartFile.fromPath('color', filename[index].path));

    var res = await request.send();
    final respStr = await res.stream.bytesToString();
    debugPrint(respStr.toString()+"fsdfd");
    debugPrint(res.statusCode.toString());
    return res.reasonPhrase;
  }
}
class UploadZip {
  String? token;

  Future<String?> uploadImage(List<PlatformFile> filename, int index,BuildContext context) async {
    await Token().tokenDosyaOku().then((value) {
      token = value;
    });
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            "${IpAddress().ipAddress}/seller/products/upload-zip"));
    request.headers.addAll({
      "Content-Type": "application/json",
      'Authorization': 'Bearer ${token}',
    });
    debugPrint(filename[index].path.toString()+"5698");


    request.files
        .add(await http.MultipartFile.fromPath('zip', filename[index].path!));

    var res = await request.send();
    debugPrint(res.toString()+"fsdfd");
    final respStr = await res.stream.bytesToString();

    debugPrint(res.statusCode.toString()+"dfdfj");
  if(res.statusCode==201){
    // ignore: use_build_context_synchronously
    Navigator.push(context, MaterialPageRoute(builder: (context)=>Excel_File_Old()));
    return res.reasonPhrase;
  }


  }
}
class Upload_Details {
  String? token;

  Future<String?> uploadImage(List<PlatformFile> filename, int index,BuildContext context) async {
    await Token().tokenDosyaOku().then((value) {
      token = value;
    });
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            "${IpAddress().ipAddress}/seller/products/upload-details"));
    request.headers.addAll({
      "Content-Type": "application/json",
      'Authorization': 'Bearer ${token}',
    });
    debugPrint(filename[index].path.toString()+"5698");


    request.files
        .add(await http.MultipartFile.fromPath('zip', filename[index].path!));

    var res = await request.send();
    debugPrint(res.toString()+"fsdfd");
    final respStr = await res.stream.bytesToString();

    debugPrint(res.statusCode.toString()+"dfdfj");
    if(res.statusCode==201){
      // ignore: use_build_context_synchronously
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Excel_File_Old()));
      return res.reasonPhrase;
    }


  }
}
class UploadExcel {
  String? token;

  Future<String?> uploadImage(List<PlatformFile> filename, int index,BuildContext context) async {
    await Token().tokenDosyaOku().then((value) {
      token = value;
    });
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            "${IpAddress().ipAddress}/seller/products/upload-excel"));
    request.headers.addAll({
      "Content-Type": "application/json",
      'Authorization': 'Bearer ${token}',
    });
    debugPrint(filename.toString()+"sdfsd");


    request.files
        .add(await http.MultipartFile.fromPath('zip', filename[index].path!));


    var res = await request.send();
    final respStr = await res.stream.bytesToString();
    debugPrint(respStr.toString()+"fsdfd");
    debugPrint(res.statusCode.toString()+"dfdfj");
    PostZip().createUser( context);
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),(route) => false);
    return res.statusCode.toString();
  }
}
class PostZip{
  String token="";
  Future createUser(
     BuildContext context) async {
    await Token().tokenDosyaOku().then((value) {
      token = value;
    });

    final response = await http.post(
        Uri.parse(
          "${IpAddress().ipAddress}/seller/products/upload-from-excel",
        ),
        headers: <String, String>{
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${token}',
        },
    );
    debugPrint(response.statusCode.toString()+"dsf");
    debugPrint(response.body);
    if (response.statusCode == 201) {
      // ColorPhoto().uploadImage(
      //     filename,(json.decode(response.body)["product_color"]["product_color_id"]).toString(), index);


      return response.body;
    } else {

      throw Exception("faild");
    }
  }}