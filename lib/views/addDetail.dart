import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dukanlar/IpAddress.dart';
import 'package:dukanlar/server/Products/OneProduct.dart';
import 'package:dukanlar/views/AddProduct/AddColor.dart';
import 'package:dukanlar/views/bottomAddPhoto/BottomAddPhoto.dart';
import 'package:dukanlar/views/bottomAddPhoto/BottomSendInfo.dart';
import 'package:dukanlar/views/bottomAddPhoto/TextFieldAddProduct.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

import '../Model/LanguageModel.dart';
import '../Model/ProductModel.dart';
import '../server/AddProduct.dart';

class AddProductDetail extends StatefulWidget {
  String subcatId;
  String cateId;
  String catname;
  String subcatname;
  bool newProduct;
  String prodId;
  LanguageModel lan;
  String url;
  AddProductDetail(
      {required this.cateId,
      required this.catname,
      required this.subcatId,
      required this.subcatname,
      required this.newProduct,
      required this.prodId,required this.lan,required this.url});

  @override
  State<AddProductDetail> createState() => _AddProductDetailState();
}

class _AddProductDetailState extends State<AddProductDetail> {
  int currentPos = 0;
  bool change = false;
  String selectedCategory = "l";
  bool checkSotk=true;
  List images = [
    "asset/images/p.jpg",
    "asset/images/p.jpg",
  ];
 late List maglummat;

  Future<ProductModel>? productModel;
@override
  void initState() {
    // TODO: implement initState
  maglummat=  [
    ["", widget.lan.harytady, " (Turkmence)"],
    ["", widget.lan.harytady, " (на русском)"],
    ["", widget.lan.gysgaMaglumatTm, "(Türkmençe)"],
    ["", widget.lan.gysgaMaglumatRu, "(на русском)"],
    ["", widget.lan.baha, ""],
    ["", widget.lan.arzanladys, ""],
    ["", widget.lan.harytCode, ""],
  ];
    super.initState();
  }
  final _logInKey = GlobalKey<FormState>();
  bool otomatikKontrol = false;
  bool discount = false;
  List colorInfo = [];
  List sized = [];
  List<XFile> photoColor = [];
bool action=false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title:  Text(widget.url=="tm"?'Siz maglumatlaryňyzy ýatda saklatjakmy':"Сохраним ли мы вашу информацию?"),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child:  Text(widget.url=="tm"?'Hawa':"Да"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child:  Text(widget.url=="tm"?'Ýok':"Нет"),
                ),
              ],
            );
          },
        );
        return shouldPop!;
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text(widget.url=="tm"?"Täze haryt goşmak".toString():"Добавить новый продукт"),
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: const Color.fromRGBO(239, 239, 239, 1)),
                child: const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Icon(Icons.arrow_back_ios),
                ),
              ),
            ),
          ),
          body: bodyAdd()),
    );
  }
valida(){

}
  bodyAdd() {
    return CustomScrollView(
      slivers: [
        SliverList(
            delegate: SliverChildListDelegate([
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// big picture or video

              /// picture list
              imageFileList.length != 0
                  ? Container(
                      //color: Colors.yellowAccent,
                      height: 70,
                      margin: const EdgeInsets.only(
                          right: 10, top: 8, bottom: 15, left: 20),
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return Stack(
                              children: [
                                Container(
                                    height: 70,
                                    width: 70,
                                    margin: const EdgeInsets.only(
                                        left: 8, right: 2),
                                    decoration: BoxDecoration(
                                        //color: Colors.greenAccent,
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: const Color.fromRGBO(
                                                239, 239, 239, 1))),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Image.file(
                                            File(imageFileList[index].path),
                                            fit: BoxFit.cover))),
                                Positioned(
                                    right: 5,
                                    child: InkWell(
                                      onTap: () {
                                        imageFileList.removeAt(index);
                                        setState(() {});
                                      },
                                      child: Icon(
                                        Icons.remove_circle_outline,
                                        color: Colors.red,
                                      ),
                                    ))
                              ],
                            );
                          },
                          itemCount: imageFileList.length))
                  : Container(),
              InkWell(
                onTap: () {
                  selectImages();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 45,
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: const Color.fromRGBO(255, 20, 29, 1)),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("asset/logo/AddPhoto.svg"),
                       Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          widget.url=="tm"?"Surat goş":"Добавить фото",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 12),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Form(
                key: _logInKey,
                child: Column(
                  children: [
                    TextFieldAddProduct().addText(
                        0, maglummat[0][1], true, true, maglummat, "", false,false,maglummat[0][2],true),
                    TextFieldAddProduct().addText(
                        1, maglummat[1][1], true, true, maglummat, "", false,false,maglummat[1][2],true),
                    TextFieldAddProduct().addText(
                        4, maglummat[4][1], true, false, maglummat, "", false,false,maglummat[4][2],true),
                    TextFieldAddProduct().addText(
                      6, maglummat[6][1], false, true, maglummat, "", false,false,maglummat[6][2],false),
                    SwitchListTile(value: action,   onChanged: (check) {

                      action = check;
                      // discount==false?maglummat[5][2]="":maglummat[5][2];
                      setState(() {});
                    },activeColor: Colors.red,title:  Text(widget.url=="tm"?"Action Harytlar":"Продукт действия"),),
                    SwitchListTile(value: discount,   onChanged: (check) {

                      discount = check;
                      // discount==false?maglummat[5][2]="":maglummat[5][2];
                      setState(() {});
                    },activeColor: Colors.red,title:  Text(widget.url=="tm"?"Arzanladyş barmy":"Есть ли скидка?"),),
                    discount == true
                        ? TextFieldAddProduct().addText(5, maglummat[5][1],
                            true, false, maglummat, "", false,true,maglummat[5][2],false)
                        : Container(),
                    kategoriya(widget.url=="tm"?"Kategoriýa":"Категория", widget.catname),
                    kategoriya( widget.url=="tm"? "Sub-Kategoriýa":"Подкатегория", widget.subcatname),
                    TextFieldAddProduct().addText(
                        2, maglummat[2][1], false, true, maglummat, "", false,false,maglummat[2][2],true),
                    TextFieldAddProduct().addText(
                        3, maglummat[3][1], false, true, maglummat, "", false,false,maglummat[3][2],true),
                  ],
                ),
              ),

              Container(
                margin: const EdgeInsets.only(
                    top: 15, bottom: 10, left: 20, right: 20),
                child:  Text(
                  widget.lan.gornus,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          )
        ])),
        colorInfo.length != 0
            ? SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  // List<XFile> a=photoColor[index];
                  // debugPrint(photoColor[0].toString());
                  return Container(
                    height: 70,
                    margin:
                        const EdgeInsets.only(bottom: 15, left: 20, right: 20),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromRGBO(174, 174, 174, 1),
                        ),
                        borderRadius: BorderRadius.circular(6)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            photoColor.length != 0
                                ? Image.file(File((photoColor[index]).path),
                                    fit: BoxFit.cover)
                                : Container(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IntrinsicHeight(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, top: 10),
                                    child: Row(
                                      children: [
                                        Text(
                                          colorInfo[index][0].toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15,
                                              color: Color.fromRGBO(
                                                  97, 97, 97, 1)),
                                        ),
                                        const VerticalDivider(
                                          thickness: 1.0,
                                          indent: 1,
                                          endIndent: 1,
                                          color: const Color.fromRGBO(
                                              97, 97, 97, 1),
                                        ),
                                        Text(
                                          "${colorInfo[index][2]} tmt",
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              color: Color.fromRGBO(
                                                  97, 97, 97, 1)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5, bottom: 10),
                                  child: Row(
                                    children: List.generate(
                                        sized[index]["sizes"].length,
                                        (proindex) => Container(
                                              padding: const EdgeInsets.only(
                                                  left: 15,
                                                  right: 15,
                                                  top: 5,
                                                  bottom: 5),
                                              margin: const EdgeInsets.only(
                                                  left: 5),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(3),
                                                  border: Border.all(
                                                      color:
                                                          const Color.fromRGBO(
                                                              174,
                                                              174,
                                                              174,
                                                              1))),
                                              child: Text(
                                                sized[index]["sizes"][proindex]
                                                        ["size"]
                                                    .toString(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14),
                                              ),
                                            )),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                         Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) =>  AddColor(sizeInfo: sized[index]["sizes"], colorPhoto: photoColor[index], colorInfo: colorInfo[index],lan: widget.lan,url: widget.url,)));
                            },
                            child: Icon(
                              Icons.arrow_forward,
                              color: Color.fromRGBO(174, 174, 174, 1),
                              size: 25,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }, childCount: colorInfo.length),
              )
            : SliverList(delegate: SliverChildListDelegate([])),
        SliverList(
            delegate: SliverChildListDelegate([
          InkWell(
            onTap: () {
              Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>  AddColor( lan: widget.lan,url: widget.url,)))
                  .then((value) {
                colorInfo.add(value[1]);
                photoColor.add(value[0]);
                sized.addAll([
                  {"sizes": value[2]}
                ]);
                debugPrint(colorInfo.toString());
                debugPrint(sized.toString());
                setState(() {});
              });
            },
            child: AddPhoto().addPhoto(widget.lan.gornusGos,),
          ),
           Padding(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
            child: Text(
              widget.lan!.detalSuratgos,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
            ),
          ),
          detalsFileList.length != 0
              ? Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  height: 80,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                          color: const Color.fromRGBO(174, 174, 174, 1))),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          Padding(
                              padding: const EdgeInsets.all(5),
                              child: Image.file(
                                File(detalsFileList[index].path),
                                fit: BoxFit.fill,
                                width: 70,
                                height: 70,
                              )),
                          Positioned(
                              right: 5,
                              child: InkWell(
                                onTap: (){
                                  detalsFileList.removeAt(index);
                                  setState(() {

                                  });
                                },
                                child: Icon(
                                  Icons.remove_circle_outline,
                                  color: Colors.red,
                                ),
                              ))
                        ],
                      );
                    },
                    itemCount: detalsFileList.length,
                  ),
                )
              : Container(),

          InkWell(
            onTap: () {
              DetalisFile();
            },
            child: AddPhoto().addPhoto(widget.lan.suratgosmak),
          ),
              Container(
                width: double.infinity,
                height: 45,
                padding: EdgeInsets.only(right:  13,left: 10),
                margin: EdgeInsets.only(left: 26,right: 26,top: 20,bottom: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: const Color.fromRGBO(238, 238, 238, 1)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text(
                      widget.lan.stokda,
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    Row(
                      children: [
                         Text(
                          widget.lan.no,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                        Switch(
                            activeColor: Colors.red,
                            value: checkSotk,
                            onChanged: (value) {
                              checkSotk = value;
                              setState(() {

                              });
                            }),
                         Text(
                          widget.lan.yes,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              InkWell(
              onTap: () {
                logInOpen(context);
              },
              child: BottomSendInfo().bottomSendInfo(context,widget.url))
        ])),
      ],
    );
  }

  void logInOpen(BuildContext context) async {
    if (_logInKey.currentState!.validate()) {
      _logInKey.currentState!.save();

      await AddProduct().createUser(
          maglummat[6][0],action,checkSotk==true?"1":"0",
          maglummat[0][0],
          maglummat[1][0],
          maglummat[2][0],
          maglummat[3][0],
          maglummat[4][0],
          widget.cateId,
          widget.subcatId,
          discount == false ? "0" : maglummat[5][0],
          "120",
          imageFileList,
          detalsFileList,
          colorInfo,
          photoColor,
          sized,context);

      Navigator.pop(context);
      Navigator.pop(context);
      setState(() {});
    } else {
      setState(() {
        otomatikKontrol = true;
      });
    }
  }

  final ImagePicker imagePicker = ImagePicker();

  List<XFile> imageFileList = [];

  void selectImages() async {
    final List<XFile> selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      imageFileList.addAll(selectedImages);
    }
    setState(() {});
  }

  final ImagePicker detailsPicker = ImagePicker();

  List<XFile> detalsFileList = [];

  void DetalisFile() async {
    final List<XFile>? detal = await detailsPicker.pickMultiImage();
    if (detal!.isNotEmpty) {
      detalsFileList.addAll(detal);
    }
    setState(() {});
  }

  kategoriya(String kategoriya, String nameCate) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin:
              const EdgeInsets.only(top: 15, bottom: 10, left: 20, right: 20),
          child: Text(
            kategoriya,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
          ),
        ),
        Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(left: 20, right: 20),
          padding: const EdgeInsets.only(left: 15),
          decoration: BoxDecoration(
              color: const Color.fromRGBO(238, 238, 238, 1),
              borderRadius: BorderRadius.circular(8)),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                nameCate,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              )),
        ),
      ],
    );
  }
}
