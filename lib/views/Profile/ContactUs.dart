import 'package:dukanlar/Model/LanguageModel.dart';
import 'package:flutter/material.dart';

import '../../server/ContactUs.dart';

class Contact extends StatefulWidget {
  LanguageModel lan;
  String url;
  Contact({required this.url,required this.lan});

  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {

  int grvalue = 1;

  late String
  _signUpname,
      _signUpLogin,
      _signUpnumber,
      _message;

  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.url=="tm"?"Habarlaşmak":"Общаться"),
      ),
      body: ListView(
        children: [

          Form(
            key: _formkey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Padding(
                  padding:
                  const EdgeInsets.only(left: 15, top: 15),
                  child: Text(
                    widget.url=="tm"?"Adyňyz we familiýaňyz":"Ваше имя и фамилия",
                    style: TextStyle( fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Color.fromRGBO(97, 97, 97, 1)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    textAlignVertical: TextAlignVertical.top,

                    // cursorColor: Color.fromRGBO(104, 109, 118, 1),

                    decoration: InputDecoration(
                      // hintStyle:CustomTextStyle.fieldmax(context),
                      errorStyle:
                     TextStyle( fontSize: 14, fontWeight: FontWeight.w400, color: Color.fromRGBO(255, 20, 29, 1)),
                      // hintText: "min",
                    ),
                    // validator: (jog) {
                    //   if (jog!.length == 0) {
                    //     return "full";
                    //   } else {
                    //     return null;
                    //   }
                    // },
                    onSaved: (deger) => _signUpname = deger!,
                  ),
                ),

                Padding(
                  padding:
                  const EdgeInsets.only(left: 15, top: 15),
                  child: Text(
                   widget.url=="tm"? "Telefon belgiňiz":"Ваш номер телефона",
                    style:  TextStyle( fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Color.fromRGBO(97, 97, 97, 1)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    textAlignVertical: TextAlignVertical.top,

                    // cursorColor: Color.fromRGBO(104, 109, 118, 1),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixText: "+993",
                      // hintStyle:CustomTextStyle.fieldmax(context),
                      errorStyle:
                      TextStyle( fontSize: 14, fontWeight: FontWeight.w400, color: Color.fromRGBO(255, 20, 29, 1)),

                      // hintText: "min",
                    ),
                    // validator: (jog) {
                    //   if (jog!.length == 0) {
                    //     return "full";
                    //   } else {
                    //     return null;
                    //   }
                    // },
                    onSaved: (deger) => _signUpnumber = deger!,
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(left: 15, top: 15),
                  child: Text(
                    widget.url=="tm"?"Email (hökman däl)":"Электронная почта (необязательно)",
                    style: TextStyle( fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Color.fromRGBO(97, 97, 97, 1)),
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    textAlignVertical: TextAlignVertical.top,

                    // cursorColor: Color.fromRGBO(104, 109, 118, 1),

                    decoration: InputDecoration(
                      // hintStyle:CustomTextStyle.fieldmax(context),
                      errorStyle:
                      TextStyle( fontSize: 14, fontWeight: FontWeight.w400, color: Color.fromRGBO(255, 20, 29, 1)),

                      // hintText: "min",
                    ),
                    // validator: (jog) {
                    //   if (jog!.length == 0) {
                    //     return "full";
                    //   } else {
                    //     return null;
                    //   }
                    // },
                    onSaved: (deger) => _signUpLogin = deger!,
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(left: 15, top: 15),
                  child: Text(
                    widget.url=="tm"?"Hatyňyz":"Ваше письмо",
                    style:TextStyle( fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Color.fromRGBO(97, 97, 97, 1)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    maxLines: 4,
                    textAlignVertical: TextAlignVertical.top,

                    // cursorColor: Color.fromRGBO(104, 109, 118, 1),

                    decoration: InputDecoration(
                      // hintStyle:CustomTextStyle.fieldmax(context),
                      errorStyle:
                      TextStyle( fontSize: 14, fontWeight: FontWeight.w400, color: Color.fromRGBO(255, 20, 29, 1)),

                      // hintText: "min",
                    ),
                    // validator: (jog) {
                    //   if (jog!.length == 0) {
                    //     return "full";
                    //   } else {
                    //     return null;
                    //   }
                    // },
                    onSaved: (deger) => _message = deger!,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: (){
              method();
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                  left: 15, right: 15, bottom: 5, top: 20),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 20, 29, 1),
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
               widget.url=="tm"? "Ugrat":"отправлять",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(255, 255, 255, 1)),
              ),
            ),
          ),
        ],
      ),
    );
  }
  method(){
    if(_formkey.currentState!.validate()){
      _formkey.currentState!.save();
      Contact_Us_Model().createUser(_signUpname, _signUpLogin, _signUpnumber,_message,context);
    }
    else{
      setState(() {

      });
    }
  }
}
