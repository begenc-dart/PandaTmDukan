import 'dart:io';

import 'package:dukanlar/IpAddress.dart';
import 'package:dukanlar/Model/GetMeModel.dart';
import 'package:dukanlar/server/Account.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../Model/LanguageModel.dart';

// ignore: camel_case_types
class Profile_Users extends StatefulWidget {
  ModelGetMe getMe;
LanguageModel lan;
String url;
  Profile_Users({required this.getMe,required this.lan,required this.url});

  @override
  State<Profile_Users> createState() => _Profile_UsersState();
}

// ignore: camel_case_types
class _Profile_UsersState extends State<Profile_Users> {
  List profile = [];
  final _logInKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profile = [
      ["", widget.url=="tm"?"Dükanyň ady (Türkmençe)":"Название магазина (Türkmençe)", widget.getMe.nameTm],
      ["", widget.url=="tm"?"Dükanyň ady (на русском)":"Название магазина (на русском)", widget.getMe.nameRu],
      ["", widget.url=="tm"?"Salgyňyz (Türkmençe)":"Ваш адрес (Türkmençe)", widget.getMe.addressTm],
      ["", widget.url=="tm"?"Salgyňyz (на русском)":"Ваш адрес (на русском)", widget.getMe.addressRu],
      ["", widget.url=="tm"?"Telefon belgi":"Номер телефона", widget.getMe.phoneNumber],
      ["", widget.url=="tm"?"Goşmaça telefon belgi":"Дополнительный номер телефона", widget.getMe.phoneNumberExtra],
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(239, 239, 239, 1),
                  borderRadius: BorderRadius.circular(5),
                ),
                alignment: Alignment.center,
                child: const Center(
                  child: Icon(Icons.arrow_back_ios),
                ),
              ),
            ),
             Expanded(
               child: Container(
                 width: MediaQuery.of(context).size.width,
                 child: Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(widget.url=="tm"?"Dükanyň infosyny üýtgetmek":"Изменить информацию о магазине"),
            ),
               ),
             ),
          ],
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 30, top: 25),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 40, right: 20),
                  child: imageFileList.path.length != 0
                      ? CircleAvatar(
                          radius: 70,
                          backgroundImage: FileImage(File(imageFileList.path)))
                      : CircleAvatar(
                          radius: 70,
                          backgroundImage: NetworkImage(
                            "${IpAddress().ipAddress}/" +
                                widget.getMe.image.toString(),
                          ),
                        ),
                ),
                InkWell(
                  onTap: () {
                    selectImages();
                  },
                  child: Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width*0.3,

                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: const Color.fromRGBO(174, 174, 174, 1))),
                    child:  Center(
                        child: Text(
                     widget.url=="tm"? "Surat çalyşmak":"Замена изображения",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    )),
                  ),
                )
              ],
            ),
          ),
          Form(
              key: _logInKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (int i = 0; i < profile.length; i++)
                    InputUsers(i, profile[i][1], profile[i][2].toString()),
                ],
              )),
          InkWell(
            onTap: () {
              logInOpen(context);
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
                  widget.url=="tm"?"Dowam et":"Продолжать",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void logInOpen(BuildContext context) async {
    if (_logInKey.currentState!.validate()) {
      _logInKey.currentState!.save();
      DukanInfo().createUser(profile[0][0], profile[1][0], profile[2][0],
          profile[3][0], imageFileList, context);
      debugPrint(profile[0][0] + profile[1][0]);
    } else {
      setState(() {});
    }
  }

  // ignore: non_constant_identifier_names
  InputUsers(int input, String name, String gosmaca) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 35),
          child: Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 20),
          child: TextFormField(
            initialValue: gosmaca != "null" ? gosmaca : "",
            textAlignVertical: TextAlignVertical.top,

            // cursorColor: Color.fromRGBO(104, 109, 118, 1),

            decoration: const InputDecoration(
                // hintStyle:CustomTextStyle.fieldmax(context),

                // hintText: "min",
                ),
            // validator: (jog) {
            //   if (jog!.length == 0) {
            //     return "full";
            //   } else {
            //     return null;
            //   }
            // },
            onSaved: (deger) => profile[input][0] = deger,
          ),
        ),
      ],
    );
  }

  final ImagePicker imagePicker = ImagePicker();

  late XFile imageFileList = XFile("");

  void selectImages() async {
    final XFile? selectedImages =
        await imagePicker.pickImage(source: ImageSource.gallery);

    imageFileList = selectedImages!;

    setState(() {});
  }
}
