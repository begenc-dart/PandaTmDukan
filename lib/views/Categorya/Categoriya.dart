import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../CategorChangeNoti.dart';
import '../../Database/Language/GetLanguage.dart';
import '../../Model/CategoriyaQT.dart';
import '../../Model/LanguageModel.dart';
import '../../server/CategoryaModel.dart';
import '../Search/Search.dart';
import 'SubCategor/SubCategoriya.dart';
import 'package:http/http.dart' as http;

class Categoriya extends StatefulWidget {
  const Categoriya({Key? key}) : super(key: key);

  @override
  _CategoriyaState createState() => _CategoriyaState();
}

class _CategoriyaState extends State<Categoriya> {
  Future<List<CategoriyaModel>>? categoriya;
  int a = 0;

  @override
  void initState() {
    // TODO: implement initState
    categoriya = caregoriyaAlbum();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<LanguageNot>(context);

    final pro = Provider.of<ChangeNot>(context);
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return FutureBuilder(
        future: Language().fetchAlbum(context),
        builder: (BuildContext context, AsyncSnapshot<LanguageModel> lanData) {
          if (lanData.hasData) {
            return SafeArea(
              child: Scaffold(
                body: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        showSearch(
                            context: context,
                            // delegate to customize the search bar
                            delegate: CustomSearchDelegate(url: themeProvider.sana, lan: lanData.data!));
                      },
                      child: Container(
                        margin: const EdgeInsets.only(
                            left: 15, right: 15, top: 5, bottom: 5),
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        height: 40,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(236, 236, 236, 1),
                            borderRadius: BorderRadius.all(Radius.circular(20))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              lanData.data!.search,
                              style: TextStyle(
                                  color: Color.fromRGBO(132, 132, 132, 0.48),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                            SvgPicture.asset("asset/icon/qr.svg")
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Row(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height *0.8369,
                              width: 110,
                              color: Color.fromRGBO(248, 248, 248, 1),
                              child: ListView.builder(
                                  itemCount: pro.sana.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return InkWell(
                                        onTap: () {
                                          setState(() {
                                            a = index;
                                          });
                                        },
                                        child: index == a
                                            ? Container(
                                            height: 60,
                                            color: Colors.white,
                                            child: Row(
                                              children: [
                                                Container(
                                                  margin:
                                                  EdgeInsets.only(right: 15),
                                                  width: 5,
                                                  height: 40,
                                                  color: Color.fromRGBO(
                                                      255, 20, 29, 1),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                      themeProvider.sana=="tm"?  pro.sana[index].nameTm:pro.sana[index].nameRu,
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                          FontWeight.w700,
                                                          color: Color.fromRGBO(
                                                              41, 41, 41, 1))),
                                                ),
                                              ],
                                            ))
                                            : Container(
                                          // margin: EdgeInsets.only(left: 5),
                                            height: 60,
                                            child: Center(
                                              child: Text(
                                                themeProvider.sana=="tm"?  pro.sana[index].nameTm:pro.sana[index].nameRu,


                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w700,
                                                    color: Color.fromRGBO(
                                                        41, 41, 41, 1)),
                                                textAlign: TextAlign.center,
                                              ),
                                            )));
                                  }),
                            ),
                            Subcategoriya(
                              subCate: pro.sana[a].subcategories!,
                              cate: pro.sana[a], lan: lanData.data!,
                              url: themeProvider.sana,
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );

          } else {
            return Center(child: CircularProgressIndicator());
          }
        });


  }
}
