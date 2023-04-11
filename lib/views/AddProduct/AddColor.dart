import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dukanlar/Model/ProductModel.dart';
import 'package:dukanlar/server/AddColor.dart';
import 'package:dukanlar/views/bottomAddPhoto/BottomAddPhoto.dart';
import 'package:dukanlar/views/bottomAddPhoto/BottomSendInfo.dart';
import 'package:dukanlar/views/bottomAddPhoto/TextFieldAddProduct.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../IpAddress.dart';
import '../../Model/LanguageModel.dart';
import '../../server/ColorPhoto.dart';
import '../../server/Products/deleteProduct.dart';

class AddColor extends StatefulWidget {
  late List? colorInfo;

  late XFile? colorPhoto;
  List<Map>? sizeInfo;
LanguageModel? lan;
String? url;
  AddColor({this.colorInfo, this.colorPhoto, this.sizeInfo, this.url, this.lan});

  @override
  State<AddColor> createState() => _AddColorState();
}

class _AddColorState extends State<AddColor> {
  List maglummat = [

  ];
  List<Map> size = [];
  List addSize = [
    {"size": "", "price": "", "quantity": 1,"discount":0},
  ];
  final _logInKey = GlobalKey<FormState>();
  final _SizedKey = GlobalKey<FormState>();
  int a = 0;

  @override
  void initState() {
    // TODO: implement initStateW
    debugPrint(widget.colorInfo.toString());
    debugPrint(widget.lan
        .toString());
    debugPrint(widget.colorPhoto.toString());
    imageFileList = widget.colorPhoto != null ? widget.colorPhoto! : XFile("");
    maglummat = [
      [
        widget.colorInfo == null ? "" : "${widget.colorInfo![0]}",
        widget.lan!.gornusAdyTm.toString(),
        "(Türkmençe)"
      ],
      [
        widget.colorInfo == null ? "" : "${widget.colorInfo![1]}",
        widget.lan!.gornusAdyRu.toString(),
        "на русском"
      ],
      [widget.colorInfo == null ? "" : "${widget.colorInfo![2]}", widget.lan!.baha.toString(), ""],
    ];
    debugPrint(widget.sizeInfo.toString());
    size = (widget.sizeInfo != null ? widget.sizeInfo : [])!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(widget.colorInfo.toString()+"dfsf");
    return Scaffold(
        appBar: AppBar(
          title:  Text(widget.url=="tm"?"Haryta görnüş goşmak":"Добавить представление к продукту"),
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
        body: CustomScrollView(slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                /// big picture or video

                /// picture list
                imageFileList.path.isNotEmpty
                    ? Container(
                        //color: Colors.yellowAccent,
                        height: 70,
                        margin: const EdgeInsets.only(
                            right: 10, top: 8, bottom: 15, left: 20),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            a = 1;
                            return Container(
                              height: 70,
                              width: 70,
                              margin: const EdgeInsets.only(left: 8, right: 2),
                              decoration: BoxDecoration(
                                  //color: Colors.greenAccent,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: Color.fromRGBO(239, 239, 239, 1))),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.file(File(imageFileList.path),
                                      fit: BoxFit.cover)),
                            );
                          },
                          itemCount: 1,
                        ))
                    : Container(),
                InkWell(
                  onTap: () {
                    selectImages();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 45,
                    margin: EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromRGBO(255, 20, 29, 1)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset("asset/logo/AddPhoto.svg"),
                         Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            widget.lan!.suratgosmak,
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ]),
              Form(
                  key: _logInKey,
                  child: Column(
                    children: [
                      TextFieldAddProduct().addText(
                        0,
                        maglummat[0][1],
                        true,
                        true,
                        maglummat,
                        maglummat[0][0],
                        true,
                        false,
                        maglummat[0][2],
                        true
                      ),
                      TextFieldAddProduct().addText(
                        1,
                        maglummat[1][1],
                        true,
                        true,
                        maglummat,
                        maglummat[1][0],
                        true,
                        false,
                        maglummat[1][2],
                        true
                      ),
                    ],
                  )),
              Padding(
                padding:  EdgeInsets.only(top: 25, left: 30, bottom: 10),
                child: Text(
                  widget.lan!.olceg,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
              ),
            ]),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return size.isNotEmpty
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      margin: EdgeInsets.only(left: 30, right: 30, bottom: 10),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(238, 238, 238, 1),
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 70,
                            height: 35,
                            margin: EdgeInsets.only(left: 8),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: Color.fromRGBO(174, 174, 174, 1)),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              size[index]["size"].toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 14),
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                widget.url=="tm"?"Gutardy":"Все кончено",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                              ),
                              Switch(
                                  value: size[index]["quantity"] == 1
                                      ? true
                                      : false,
                                  activeColor: Color.fromRGBO(245, 137, 137, 1),
                                  activeTrackColor:
                                      Color.fromRGBO(217, 217, 217, 1),
                                  onChanged: (result) {
                                    size[index]["quantity"] =
                                        result == true ? 1 : 0;
                                    setState(() {});
                                  }),
                              InkWell(
                                onTap: () {
                                  size.removeAt(index);
                                  setState(() {});
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Icon(Icons.delete),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : Container();
            }, childCount: size.length),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                          actionsAlignment: MainAxisAlignment.start,
                          title: Column(
                            children: [
                              Form(
                                  key: _SizedKey,
                                  child: Column(
                                    children: [
                                      addText(0, widget.url=="tm"?"Ölçegi":"Размер", true, true, addSize,
                                          "size",false),
                                      addText(1, widget.lan!.baha, true, false, addSize,
                                          "price",false),
                                      addText(1, widget.url=="tm"?"Arzanladyş":"Скидка", true, false,
                                          addSize, "discount",true),
                                    ],
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  dropdow(context);
                                  setState(() {});
                                },
                                child: BottomSendInfo().bottomSendInfo(context,""),
                              )
                            ],
                          ));
                    });
              },
              child: AddPhoto().addPhoto(widget.lan!.olcegGos),
            ),
            SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                logInOpen(context);
              },
              child: BottomSendInfo().bottomSendInfo(context,""),
            )
          ]))
        ]));
  }

  bool otomatikKontrol = false;

  void dropdow(BuildContext context) async {
    if (_SizedKey.currentState!.validate()) {
      _SizedKey.currentState!.save();
      size.addAll([
        {
          "size": addSize[0]["size"],
          "price": addSize[0]["price"],
          "quantity": addSize[0]["quantity"],
          "discount":addSize[0]["discount"]
        }
      ]);
      debugPrint(addSize[0]["quantity"].toString());
      Navigator.pop(context);
      setState(() {});
    } else {
      setState(() {
        otomatikKontrol = true;
      });
    }
  }

  void logInOpen(BuildContext context) async {
    if (_logInKey.currentState!.validate()) {
      _logInKey.currentState!.save();

      Navigator.pop(context, [
        imageFileList,
        [maglummat[0][0], maglummat[1][0], maglummat[2][0]],
        size
      ]);
      setState(() {});
    } else {
      setState(() {
        otomatikKontrol = true;
      });
    }
  }

  addText(int text, String info, bool check, bool checkNum, List maglummat,
      String index,bool checkdis) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin:
              const EdgeInsets.only(top: 15, bottom: 10, right: 20, left: 20),
          child: Text(
            info,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: TextFormField(
            keyboardType:
                checkNum == true ? TextInputType.text : TextInputType.number,
            minLines: 1,
            maxLines: check == true ? 1 : null,
            maxLength: checkdis==true?2:null,
            decoration: const InputDecoration(
              contentPadding: const EdgeInsets.all(12),
            ),
            onSaved: (result) {
              addSize[0][index] = result!;
            },
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

class AddColorEdit extends StatefulWidget {
  late List? colorInfo;
ProductColor color;
int index;
  List<ProductSize>? sizeInfo;
String id;
  LanguageModel lan;
  String url;
  AddColorEdit({this.colorInfo,  this.sizeInfo,required this.color,required this.index,required this.id,required this.lan,required this.url});

  @override
  State<AddColorEdit> createState() => _AddColorEditState();
}

class _AddColorEditState extends State<AddColorEdit> {
  List maglummat = [
    ["", "Görnüşiň (Reňkiň) ady Türkmençe"],
    ["", "Görnüşiň (Reňkiň) ady на русском"],
    ["", "Bahasy"],
  ];
  List<Map> size = [];
  List addSize = [
    {"size": "", "price": "", "quantity": 1,"discount":0},
  ];
  final _logInKey = GlobalKey<FormState>();
  final _SizedKey = GlobalKey<FormState>();
  int a = 0;

  @override
  void initState() {
    // TODO: implement initStateW
    debugPrint(widget.colorInfo.toString());
    debugPrint(widget.sizeInfo.toString());
    // debugPrint(widget.colorPhoto.toString());
    // imageFileList = widget.colorPhoto != null ? widget.colorPhoto! : XFile("");
    maglummat = [
      [
        widget.colorInfo!.isNotEmpty ? "${widget.colorInfo![0]}" : widget.color.colorNameTm,
    widget.lan.gornusAdyTm.toString(),
        "(Türkmençe)"
      ],
      [
        widget.colorInfo!.isNotEmpty ? "${widget.colorInfo![1]}" : widget.color.colorNameRu,
        widget.lan.gornusAdyRu.toString(),
        "на русском"
      ],
      ["", widget.lan.baha.toString(),],
    ];
    // size = (widget.sizeInfo != null ? widget.sizeInfo : [])!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(widget.colorInfo.toString());
    return Scaffold(
        appBar: AppBar(
          title:  Text(widget.url=="tm"?"Haryta görnüş goşmak":"Добавить представление к продукту"),
          actions:[ InkWell(
            onTap: (){
              DeleteColor().fetchAlbum(widget.color.productColorId!);
              Navigator.pop(context,true);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Icon(Icons.delete),
            ),
          )],
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
        body: CustomScrollView(slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                /// big picture or video

                /// picture list
                imageFileList.path.isNotEmpty|| widget.color.productImages!.isNotEmpty
                    ? Container(
                  //color: Colors.yellowAccent,
                    height: 70,
                    margin: const EdgeInsets.only(
                        right: 10, top: 8, bottom: 15, left: 20),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        a = 1;
                        return Container(
                          height: 70,
                          width: 70,
                          margin: const EdgeInsets.only(left: 8, right: 2),
                          decoration: BoxDecoration(
                            //color: Colors.greenAccent,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color: Color.fromRGBO(239, 239, 239, 1))),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child:imageFileList.path.isNotEmpty? Image.file(File(imageFileList.path),
                                  fit: BoxFit.cover):CachedNetworkImage(
                                imageUrl: IpAddress().ipAddress +
                                    "/" +
                                    widget.color.productImages!.last.toString()
                                        ,
                                placeholder: (context, url) =>
                                    Container(
                                        alignment:
                                        Alignment.center,
                                        child:
                                        CircularProgressIndicator(
                                          color: Colors.red,
                                        )),
                                errorWidget:
                                    (context, url, error) =>
                                    Icon(Icons.access_time),
                                fit: BoxFit.fill,
                                width: 50,
                                height: 100,
                              ),),
                        );
                      },
                      itemCount: 1,
                    ))
                    : Container(),
                InkWell(
                  onTap: () {
                    selectImages(widget.color.productColorId!);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 45,
                    margin: EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromRGBO(255, 20, 29, 1)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset("asset/logo/AddPhoto.svg"),
                         Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            widget.lan.suratgosmak,
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ]),
              Form(
                  key: _logInKey,
                  child: Column(
                    children: [
                      TextFieldAddProduct().addText(
                          0,
                          maglummat[0][1],
                          true,
                          true,
                          maglummat,
                          maglummat[0][0],
                          true,
                          false,
                          maglummat[0][2],
                          true
                      ),
                      TextFieldAddProduct().addText(
                          1,
                          maglummat[1][1],
                          true,
                          true,
                          maglummat,
                          maglummat[1][0],
                          true,
                          false,
                          maglummat[1][2],
                          true
                      ),
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 25, left: 30, bottom: 10),
                child: Text(
                  widget.lan.olceg,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
              ),
            ]),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return size.isNotEmpty ||widget.sizeInfo!.isNotEmpty
                  ? Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                margin: EdgeInsets.only(left: 30, right: 30, bottom: 10),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(238, 238, 238, 1),
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 70,
                      height: 35,
                      margin: EdgeInsets.only(left: 8),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: Color.fromRGBO(174, 174, 174, 1)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        widget.color.productSizes![index].size.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 14),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          widget.url=="tm"?"Gutardy":"Все кончено",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                        Switch(
                            value:  widget.sizeInfo![index].productId == 1
                                ? true
                                : false,
                            activeColor: Color.fromRGBO(245, 137, 137, 1),
                            activeTrackColor:
                            Color.fromRGBO(217, 217, 217, 1),
                            onChanged: (result) {
                              widget.sizeInfo![index].productId =
                              result == true ? 1 : 0;
                              setState(() {});
                            }),
                        InkWell(
                          onTap: () {
                            widget.sizeInfo!.removeAt(index);
                            setState(() {});
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Icon(Icons.delete),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
                  : Container();
            }, childCount: widget.color.productSizes!.length),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
                InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                              actionsAlignment: MainAxisAlignment.start,
                              title: Column(
                                children: [
                                  Form(
                                      key: _SizedKey,
                                      child: Column(
                                        children: [
                                          addText(0, widget.url=="tm"?"Ölçegi":"Размер", true, true, addSize,
                                              "size",false),
                                          addText(1, widget.lan.baha, true, false, addSize,
                                              "price",false),
                                          addText(1, widget.url=="tm"?"Arzanladyş":"Скидка", true, false,
                                              addSize, "discount",true),
                                        ],
                                      )),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      dropdow(context);
                                      setState(() {});
                                    },
                                    child: BottomSendInfo().bottomSendInfo(context,""),
                                  )
                                ],
                              ));
                        });
                  },
                  child: AddPhoto().addPhoto(widget.lan.olcegGos),
                ),
                SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    logInOpen(context);
                  },
                  child: BottomSendInfo().bottomSendInfo(context,""),
                )
              ]))
        ]));
  }

  bool otomatikKontrol = false;

  void dropdow(BuildContext context) async {
    if (_SizedKey.currentState!.validate()) {
      _SizedKey.currentState!.save();
      size.addAll([
        {
          "size": addSize[0]["size"],
          "price": addSize[0]["price"],
          "quantity": addSize[0]["quantity"],
          "discount":addSize[0]["discount"]
        }
      ]);
      debugPrint(addSize[0]["quantity"].toString());
      Navigator.pop(context);
      setState(() {});
    } else {
      setState(() {
        otomatikKontrol = true;
      });
    }
  }

  void logInOpen(BuildContext context) async {
    if (_logInKey.currentState!.validate()) {
      _logInKey.currentState!.save();
PatchColor().createUser(maglummat[0][0], maglummat[1][0], widget.color.productColorId!, imageFileList, 0, size);
      Navigator.pop(context, [
        imageFileList,
        [maglummat[0][0], maglummat[1][0]],
        size,

      ]);
      setState(() {});
    } else {
      setState(() {
        otomatikKontrol = true;
      });
    }
  }

  addText(int text, String info, bool check, bool checkNum, List maglummat,
      String index,bool checklen) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin:
          const EdgeInsets.only(top: 15, bottom: 10, right: 20, left: 20),
          child: Text(
            info,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: TextFormField(
            keyboardType:
            checkNum == true ? TextInputType.text : TextInputType.number,
            minLines: 1,
            maxLength: checklen==true ?2:null,
            maxLines: check == true ? 1 : null,
            decoration: const InputDecoration(
              contentPadding: const EdgeInsets.all(12),
            ),
            onSaved: (result) {
              addSize[0][index] = result!;
            },
          ),
        ),
      ],
    );
  }

  final ImagePicker imagePicker = ImagePicker();

  late XFile imageFileList = XFile("");

  void selectImages(String url) async {
    final XFile? selectedImages =
    await imagePicker.pickImage(source: ImageSource.gallery);

    imageFileList = selectedImages!;
    ColorPhoto().uploadImage(
        [imageFileList],url, 0);
    setState(() {});
  }
}