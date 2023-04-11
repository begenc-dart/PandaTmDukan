import 'package:dukanlar/Model/LanguageModel.dart';
import 'package:dukanlar/main.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';

import '../../CategorChangeNoti.dart';
import '../../Database/Language/LanguagePath.dart';
import '../../server/ColorPhoto.dart';

class Excel_File extends StatefulWidget {


  @override
  State<Excel_File> createState() => _Excel_FileState();
}

class _Excel_FileState extends State<Excel_File> {
  @override
  void initState() {
    // TODO: implement initState
    language();
    super.initState();
  }
  String url="";
  language()async{
    await LanguageFileRead().then((value) {
      url = value;
    });
    setState(() {

    });
  }
  bool check=true;
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<LanguageNot>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text(themeProvider.sana=="tm" ?"Suratlaryňyzy goşuň":"Добавьте свои фотографии"),),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20,top: 20),
              child: Text(themeProvider.sana=="tm"? "Zip faýlyňyzy goşuň":"Прикрепить ZIP-файл", style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),),
            ),

            InkWell(
              onTap: () {
              check==true?  _pickFile(context):"";

                // Navigator.push(context, MaterialPageRoute(builder: (context)=>Excel_File_Old()));
              setState(() {

                });
              },
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                  color: check==true? Color.fromRGBO(255, 20, 29, 1):Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child:  Center(
                  child:  Text(
                    themeProvider.sana=="tm"? "Dowam et":"Продолжать",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
            check==false?Image.asset("asset/images/99297-loading-files.gif"):Container()
          ],
        ),
      ),
    );
  }

var files;
  List<PlatformFile> filess=[];
  void _pickFile(BuildContext context) async {

    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    // if no file is picked
    if (result == null) return;

    // we get the file from result object
     files = result.paths;
     filess=result.files;
    check=false;
    debugPrint(check.toString());
    setState(() {

    });
    UploadZip().uploadImage(filess, 0,context);

  }
}
class UploadDetails extends StatefulWidget {


  @override
  State<UploadDetails> createState() => _UploadDetailsState();
}

class _UploadDetailsState extends State<UploadDetails> {
  @override
  void initState() {
    // TODO: implement initState
    language();
    super.initState();
  }
  String url="";
  language()async{
    await LanguageFileRead().then((value) {
      url = value;
    });
  }
  @override
  bool check=true;
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<LanguageNot>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text(themeProvider.sana=="tm"?"Detail goşuň":"Добавить детали"),),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20,top: 20),
              child: Text(themeProvider.sana=="tm"?"Zip File Goşun":"Прикрепить ZIP-файл", style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),),
            ),

            InkWell(
              onTap: () {
                check==true?  _pickFile(context):"";

                // Navigator.push(context, MaterialPageRoute(builder: (context)=>Excel_File_Old()));
                setState(() {

                });
              },
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                  color: check==true? Color.fromRGBO(255, 20, 29, 1):Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child:  Center(
                  child:  Text(
                    themeProvider.sana=="tm"?"Dowam et":"Продолжать",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
            check==false?Image.asset("asset/images/99297-loading-files.gif"):Container()
          ],
        ),
      ),
    );
  }

  var files;
  List<PlatformFile> filess=[];
  void _pickFile(BuildContext context) async {

    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    // if no file is picked
    if (result == null) return;

    // we get the file from result object
    files = result.paths;
    filess=result.files;
    check=false;
    debugPrint(check.toString());
    setState(() {

    });
    Upload_Details().uploadImage(filess, 0,context);

  }
}

class Excel_File_Old extends StatefulWidget {


  @override
  State<Excel_File_Old> createState() => _Excel_File_OldState();
}

class _Excel_File_OldState extends State<Excel_File_Old> {
  void initState() {
    // TODO: implement initState
    language();
    super.initState();
  }
  String url="";
  language()async{
    await LanguageFileRead().then((value) {
      url = value;
    });
  }
  @override
  Widget build(BuildContext context) {final themeProvider = Provider.of<LanguageNot>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text(themeProvider.sana=="tm"?"Haryt goşmak":"Добавить элемент"),),
        body: Column(
          children: [
            Text("Excel".toString()),

            InkWell(
              onTap: () {
                _pickFile();

                // PostZip().createUser("", context);

                setState(() {

                });
              },
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 20, 29, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child:  Center(
                  child:  Text(
                    themeProvider.sana=="tm"?"Dowam et":"Продолжать",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.white),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  var files;
  List<PlatformFile> filess=[];
  void _pickFile() async {
    // opens storage to pick files and the picked file or files
    // are assigned into result and if no file is chosen result is null.
    // you can also toggle "allowMultiple" true or false depending on your need
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    // if no file is picked
    if (result == null) return;

    // we get the file from result object
    files = result.paths;
    filess=result.files;

    UploadExcel().uploadImage(filess, 0,context);

  }
}
