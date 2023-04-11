import 'package:dukanlar/CategorChangeNoti.dart';
import 'package:dukanlar/IpAddress.dart';
import 'package:dukanlar/views/ExcelFile/Excel_file_gos.dart';
import 'package:dukanlar/views/Profile/Profile_users.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../Database/Check.dart';
import '../../Database/Language/GetLanguage.dart';
import '../../Database/Language/LanguagePath.dart';
import '../../Model/GetMeModel.dart';
import '../../Model/LanguageModel.dart';
import '../../main.dart';
import '../../server/Get_Me.dart';
import 'ContactUs.dart';
import 'TxtHelp_me.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<LanguageNot>(context);
    return SafeArea(
        child: Scaffold(
      body: FutureBuilder(
          future: Language().fetchAlbum(context),
          builder: (BuildContext context, AsyncSnapshot<LanguageModel> lanData) {
            if (lanData.hasData) {
              List contact = [

                ["asset/logo/security.svg", lanData.data!.security, Help(
                  appbartitle: lanData.data!.security,
                  contexttitle:
                """"""
                )],
                ["asset/logo/terms.svg", lanData.data!.use, Help(
                  appbartitle: lanData.data!.use,
                  contexttitle:
                 "Habarlaşmak üçin +99363949758"  )],
                ["asset/logo/About.svg", lanData.data!.bizB, Help(
                  appbartitle: lanData.data!.bizB,
                  contexttitle:
                 url=="tm"? """Sizi PandaTm online platformasynda hoş gördük!!! 
Biz size uzakda bolan dükanlary eliňiziň aýasynda ýaly duýmaklyga kömek  bereris, ýagny islendik islän, halan harytlaryňyzy sargyt edip, islän wagtyňyzda öz gapyňyza çenli getirdip bilersiňiz. Şeýle-de bizde tölegleriň islendik görnüşinden peýdalanmak mümkinçiligiňiz bolar. Biziň esasy aladamyz siziň gymmatly wagtyňyzy tygşytlap, ony öz maşgalaňyz bilen geçirmegiňizdir. 
Siz PandaTm online platformasyny Google play marketda, IOS story-da we internet torunda (panda.com.tm) tapyp bilersiňiz. 
PandaTm siziň islegleriňizi we arzuwlaryňyzy gysga wagtda amala aşyrmak üçin döredilendir!!! 
Habarlaşmak üçin: Pandatm.delivery@gmail.com
""" :"""Добро пожаловать на онлайн-платформе PandaTm!!!
Мы поможем вам почувствовать, что маркеты или рестораны вдали от васб находятся у вас под рукой, а это означает, что вы можете заказать любой товар, который вы хотите, и получить его к вашей двери в любое время. У вас также будет возможность использовать любую форму оплаты. Наша главная задача – сэкономить ваше драгоценное время и провести его с семьей.
Вы можете найти онлайн-платформу PandaTm на Google Play, IOS story и в Интернете (panda.com.tm).
PandaTm создана для того, чтобы ваши желания и мечты сбывались в кратчайшие сроки!!!
Контакт: Pandatm.delivery@gmail.com
""" )],
                ["asset/logo/Contact.svg", lanData.data!.contact, Contact(url: url, lan: lanData.data!,)],

              ];
              return FutureBuilder(
                  future: PostGetMe().fetchAlbum(),
                  builder: (BuildContext context,
                      AsyncSnapshot<ModelGetMe> snapshot) {
                    if (snapshot.hasData) {
                      return ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, top: 30, bottom: 25),
                            child: Row(
                              children: [
                                snapshot.data!.image != null
                                    ? Padding(
                                        padding: EdgeInsets.only(
                                            left: 24, right: 20),
                                        child: CircleAvatar(
                                          minRadius: 40,
                                          backgroundColor: Colors.red,
                                          backgroundImage: NetworkImage(
                                              IpAddress().ipAddress +
                                                  "/" +
                                                  snapshot.data!.image!
                                                      .toString()),
                                        ),
                                      )
                                    : Padding(
                                        padding: EdgeInsets.only(
                                            left: 24, right: 20),
                                        child: CircleAvatar(
                                          minRadius: 40,
                                          child: Icon(Icons.person),
                                        ),
                                      ),
                                Container(
                                  width: MediaQuery.of(context).size.width-170,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            themeProvider.sana=="tm"?  snapshot.data!.nameTm.toString():snapshot.data!.nameRu.toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 18),
                                          ),
                                          Padding(
                                            padding:
                                            EdgeInsets.only(top: 7, bottom: 8),
                                            child: Container(
                                              width: MediaQuery.of(context).size.width*0.4,
                                              child: Text(
                                                snapshot.data!.addressTm!=null.toString()?    themeProvider.sana=="tm"?  snapshot.data!.addressTm.toString():snapshot.data!.addressRu.toString():"Salgyňyz",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15,
                                                    color:
                                                    Color.fromRGBO(97, 97, 97, 1),overflow: TextOverflow.ellipsis),
                                              ),
                                            ),
                                          ),
                                          Text(
                                              snapshot.data!.phoneNumber.toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 13,
                                                  color:
                                                  Color.fromRGBO(97, 97, 97, 1))),
                                          snapshot.data!.phoneNumberExtra != null
                                              ? Padding(
                                            padding: EdgeInsets.only(top: 8),
                                            child: Text(
                                                snapshot.data!.phoneNumberExtra
                                                    .toString(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 13,
                                                    color: Color.fromRGBO(
                                                        97, 97, 97, 1))),
                                          )
                                              : Container(),
                                        ],
                                      ),
                                      Container(
                                        height: 50,
                                        width: 50,
                                        //color: Colors.red,
                                        child: IconButton(
                                          icon: Icon(Icons.exit_to_app),
                                          onPressed: (){
                                            _quit(context);
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Profile_Users(
                                            getMe: snapshot.data!, lan: lanData.data!, url: url,
                                          )));
                            },
                            child: Container(
                              margin: const EdgeInsets.only(
                                  left: 20, right: 20, bottom: 20),
                              padding: const EdgeInsets.only(left: 15),
                              height: 55,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: const Color.fromRGBO(
                                          174, 174, 174, 1),
                                      width: 1)),
                              child: Row(
                                children: [
                                  SvgPicture.asset("asset/logo/edit-3.svg"),
                                   Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: Text(
                                      lanData.data!.uytget.toString(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          text('asset/logo/lang.svg', lanData.data!.dil, context,
                              Dialog(),true),
                          for (int i = 0; i < contact.length; i++)
                            text(contact[i][0], contact[i][1], context,
                                contact[i][2],false)
                        ],
                      );
                    } else {
                      return Container();
                    }
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    ));
  }

var a="";

  text(String imgUrl, String contact, BuildContext context, var linked,bool barla) {
    return InkWell(
      onTap: () {
        barla
            ? Dialog().newDialog(context)
            : Navigator.push(
                context, MaterialPageRoute(builder: (context) => linked));
      },
      child: Container(
        height: 55,
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
        decoration: BoxDecoration(
            color: const Color.fromRGBO(246, 246, 246, 1),
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: SvgPicture.asset(imgUrl),
            ),
            Text(
              contact,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            )
          ],
        ),
      ),
    );
  }

  _quit(BuildContext context)async{
    return await showDialog(
        context: context,
        builder: (context) =>AlertDialog(
          title:  Text(url=="tm"?'Siz çykmakçymy?':"Ты выходишь?"),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            TextButton(
              onPressed: () async{
                await CheckSignUp().dosyaYaz("false");

               // setState(() {});
// logInOpen(context, snapshot.data!.productId!, snapshot.data!.subcategory!.subcategoryId!, snapshot.data!.category!.categoryCategoryId!);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MatPage()),
                      (Route<dynamic> route) => false,
                );
                //Navigator.pop(context, true);
              },
              child:  Text(url=="tm"?'Hawa':"Да"),
            ),
            TextButton(
              onPressed: () {
               Navigator.pop(context, true);
              },
              child:  Text(url=="tm"?'Ýok':"Нет"),
            ),
          ],
        ));



  }
}

class Dialog {
  Future<dynamic> newDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return Container(
            width: 500,
            height: 150,
            child: SimpleDialog(
              backgroundColor: Color.fromRGBO(250, 250, 250, 1),
              titlePadding: EdgeInsets.only(left: 17, top: 16),
// title: Text(ady),
              contentPadding: EdgeInsets.only(left: 17, top: 16, bottom: 10),
              children: [
                SimpleDialogOption(
                  child: Container(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        "Turkmençe",
                        style: TextStyle(
                            fontSize: 16, color: Color.fromRGBO(41, 41, 41, 1)),
                      )),
                  onPressed: () async {
                    await LanguageFileRead().then((value) {
                      if (value == "tm" || value == null) {
                        Navigator.pop(context);
                      } else {
                        Provider.of<LanguageNot>(context, listen: false).sana =
                            "tm";
                        LanguageFileWrite('tm');
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => MyHomePage()),
                          (Route<dynamic> route) => false,
                        );
                      }
                    });
                  },
                ),
                SimpleDialogOption(
                  child: Text(
                    "Pусский",
                    style: TextStyle(
                        fontSize: 16, color: Color.fromRGBO(41, 41, 41, 1)),
                  ),
                  onPressed: () async {
                    await LanguageFileRead().then((value) {
                      if (value == "ru" || value == null) {
                        Navigator.pop(context);
                      } else {
                        Provider.of<LanguageNot>(context, listen: false).sana =
                            "ru";
                        LanguageFileWrite('ru');
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => MyHomePage()),
                          (Route<dynamic> route) => false,
                        );
                      }
                    });
                  },
                ),
              ],
            ),
          );
        });
  }
}
