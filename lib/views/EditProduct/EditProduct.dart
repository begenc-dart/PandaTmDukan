import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:dukanlar/IpAddress.dart';
import 'package:dukanlar/server/Products/EditProduct.dart';
import 'package:dukanlar/server/Products/OneProduct.dart';
import 'package:dukanlar/server/Products/deleteProduct.dart';
import 'package:dukanlar/views/AddProduct/AddColor.dart';
import 'package:dukanlar/views/bottomAddPhoto/BottomAddPhoto.dart';
import 'package:dukanlar/views/bottomAddPhoto/BottomSendInfo.dart';
import 'package:dukanlar/views/bottomAddPhoto/TextFieldAddProduct.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import '../../Model/LanguageModel.dart';
import '../../Model/ProductModel.dart';
import '../../main.dart';

class EditProductResult extends StatefulWidget {
  bool newProduct;
  String prodId;
  bool action;
  bool discount;
LanguageModel? lan;
String? url;
  EditProductResult(
      {required this.newProduct,
      required this.prodId,
      required this.discount,
      required this.action, this.lan, this.url});

  @override
  State<EditProductResult> createState() => _EditProductResultState();
}

class _EditProductResultState extends State<EditProductResult> {
  int currentPos = 0;
  bool change = false;
  String selectedCategory = "l";
  bool checkSotk = true;
  late List maglummat;
  Future<ProductModel>? productModel;

  final _logInKey = GlobalKey<FormState>();
  bool otomatikKontrol = false;

  List colorInfo = [];
  List sized = [];
  List<XFile> photoColor = [];
  String subCat = "";
  String cat = "";
  String id = "";
  String subCatid = "";
  String catid = "";
  //FToast? fToast;
stokme()async{
   await OneProduct().fetchAlbum(widget.prodId).then((value) {
     checkSotk=value.productStock[0].quantity==0?false:true;
   });
}
  @override
  void initState() {
  stokme();
    productModel = OneProduct().fetchAlbum(widget.prodId);
    // fToast = FToast();
    // fToast!.init(context);

maglummat=  [
  ["", widget.lan!.harytady, " (Turkmence)"],
  ["", widget.lan!.harytady, " (на русском)"],
  ["", widget.lan!.gysgaMaglumatTm, "(Türkmençe)"],
  ["", widget.lan!.gysgaMaglumatRu, "(на русском)"],
  ["", widget.lan!.baha, ""],
  ["", widget.lan!.arzanladys, ""],
  ["", widget.lan!.harytCode, ""],
];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
        future: productModel,
        builder: (context, AsyncSnapshot<ProductModel> snapshot){
      if(snapshot.hasData){
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
                        setState(() {});
logInOpen(context, snapshot.data!.productId!, snapshot.data!.subcategory!.subcategoryId!, snapshot.data!.category!.categoryCategoryId!);

                        // Navigator.pop(context, true);
                      },
                      child:  Text(widget.url=="tm"?'Hawa':"Да"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, true);
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
                automaticallyImplyLeading: false,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.url=="tm"?"Täze haryt goşmak".toString():"Добавить новый продукт"),
                    InkWell(
                        onTap: () {
                          productModel!.then((value) =>
                              DeleteProduct().fetchAlbum(value.productId!));
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => MyHomePage()),
                                  (route) => false);
                        },
                        child: Icon(
                          Icons.delete,
                        ))
                  ],
                ),
                leading: InkWell(
                  onTap: () async{
                    setState(() {
                      Navigator.of(context, rootNavigator:true).maybePop();
                    });



                 // Navigator.pop(context,false);

                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromRGBO(239, 239, 239, 1)),
                    padding: EdgeInsets.only(left: 10),
                    alignment: Alignment.center,
                    child: Center(child: const Icon(Icons.arrow_back_ios)),
                  ),
                ),
              ),
              body: body(productModel: snapshot.data)
        ));
      }
      else{
        return Scaffold(body: Center(child: CircularProgressIndicator()));
      }
    });
  }

  body({ProductModel? productModel}) {
    return CustomScrollView(
      slivers: [
        SliverList(
            delegate: SliverChildListDelegate([
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// big picture or video

              /// picture list
              Container(
                  //color: Colors.yellowAccent,
                  height: 70,
                  margin: const EdgeInsets.only(
                      right: 10, top: 8, bottom: 15, left: 20),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                            height: 70,
                            width: 70,
                            margin: const EdgeInsets.only(left: 8, right: 2),
                            decoration: BoxDecoration(
                                //color: Colors.greenAccent,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: const Color.fromRGBO(
                                        239, 239, 239, 1))),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: index < imageFileList.length
                                  ? Stack(
                                      children: [
                                        Image.file(
                                            File(imageFileList[index].path),
                                            fit: BoxFit.cover),
                                        Positioned(
                                          right: 5,
                                          child: InkWell(
                                              onTap: () {
                                                imageFileList.removeAt(index);
                                                setState(() {});
                                              },
                                              child: Icon(
                                                Icons.remove_circle,
                                                color: Colors.red,
                                              )),
                                        ),
                                      ],
                                    )
                                  : Stack(
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl: IpAddress().ipAddress +
                                              "/" +
                                              productModel
                                                  .images![index -
                                                      imageFileList.length]
                                                  .image
                                                  .toString(),
                                          placeholder: (context, url) =>
                                              Container(
                                                  alignment: Alignment.center,
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: Colors.red,
                                                  )),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.access_time),
                                          fit: BoxFit.fill,
                                        ),
                                        Positioned(
                                          right: 5,
                                          child: InkWell(
                                              onTap: () {
                                                DeletePhoto().fetchAlbum(
                                                    productModel
                                                        .images![index -
                                                            imageFileList
                                                                .length]
                                                        .imageId
                                                        .toString());
                                                productModel.images!.removeAt(
                                                    index -
                                                        imageFileList.length);
                                                setState(() {});
                                              },
                                              child: Icon(
                                                Icons.remove_circle,
                                                color: Colors.red,
                                              )),
                                        ),
                                      ],
                                    ),
                            ));
                      },
                      itemCount:
                          productModel!.images!.length + imageFileList.length)),
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
                        0,
                        maglummat[0][1],
                        true,
                        true,
                        maglummat,
                        productModel.nameTm!,
                        true,
                        false,
                        maglummat[0][2],
                        true),
                    TextFieldAddProduct().addText(
                        1,
                        maglummat[1][1],
                        true,
                        true,
                        maglummat,
                        productModel.nameRu!,
                        true,
                        false,
                        maglummat[1][2],
                        true),
                    TextFieldAddProduct().addText(
                        4,
                        maglummat[4][1],
                        true,
                        false,
                        maglummat,
                        productModel.priceOld == 0||productModel.priceOld == null?productModel.price.toString(): productModel.priceOld.toString(),

                        true,
                        false,
                        maglummat[4][2],
                        true),
                    TextFieldAddProduct().addText(
                        6,
                        maglummat[6][1],
                        true,
                        false,
                        maglummat,
                        productModel.productCode == null
                            ? ""
                            : productModel.productCode.toString(),
                        true,
                        false,
                        maglummat[6][2],
                        false),
                    SwitchListTile(
                      value: widget.action,
                      onChanged: (check) {
                        widget.action = check;
                        // discount==false?maglummat[5][2]="":maglummat[5][2];
                        setState(() {});
                      },
                      activeColor: Colors.red,
                      title:  Text(widget.url=="tm"?"Action Harytlar":"Продукт действия"),
                    ),
                    SwitchListTile(
                      value: widget.discount,
                      onChanged: (check) {
                        widget.discount = check;
                        // discount==false?maglummat[5][2]="":maglummat[5][2];
                        setState(() {});
                      },
                      activeColor: Colors.red,
                      title:  Text(widget.url=="tm"?"Arzanladyş barmy":"Есть ли скидка?"),
                    ),
                    widget.discount == true
                        ? TextFieldAddProduct().addText(
                            5,
                            maglummat[5][1],
                            true,
                            false,
                            maglummat,
                            productModel.discount != null
                                ? productModel.discount.toString()
                                : "",
                            true,
                            true,
                            maglummat[5][2],
                            false)
                        : Container(),
                    kategoriya(widget.url=="tm"?"Kategoriýa":"Категория", productModel.category!.nameTm!),
                    kategoriya(
                        widget.url=="tm"? "Sub-Kategoriýa":"Подкатегория", productModel.subcategory!.nameTm!),
                    TextFieldAddProduct().addText(
                        2,
                        maglummat[2][1],
                        false,
                        true,
                        maglummat,
                        productModel.bodyTm!,
                        true,
                        false,
                        maglummat[2][2],
                        true),
                    TextFieldAddProduct().addText(
                        3,
                        maglummat[3][1],
                        false,
                        true,
                        maglummat,
                        productModel.bodyRu!,
                        true,
                        false,
                        maglummat[3][2],
                        true),
                  ],
                ),
              ),

              Container(
                margin: const EdgeInsets.only(
                    top: 15, bottom: 10, left: 20, right: 20),
                child:  Text(
                  widget.lan!.gornus,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          )
        ])),
        colorInfo.length != 0 || productModel.productColors!.length != 0
            ? SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  // List<XFile> a=photoColor[index];
                  // debugPrint(photoColor[0].toString());
                  return InkWell(
                    onTap: () {
                      index < colorInfo.length
                          ?Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>  AddColor(sizeInfo: sized[index]["sizes"], colorPhoto: photoColor[index], colorInfo: colorInfo[index], url: widget.url!,lan: widget.lan!,))):Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>  AddColorEdit(sizeInfo: productModel.productSizes,  colorInfo: colorInfo.length!=0?colorInfo[index- photoColor.length]:[], color:productModel
                              .productColors![
                          index - photoColor.length], url: widget.url!,lan: widget.lan!, index: index, id: productModel.productId!,))) .then((value) {
                        value==true?productModel
                            .productColors!.removeAt(index - photoColor.length):    productModel
                            .productColors![
                        index - photoColor.length].colorNameTm=value[1][0];
                        print(value.toString()+"fdgf");


                        // colorInfo[index]=value[1];
                        // photoColor[index]=value[0];
                        // sized[index]=([
                        //   {"sizes": value[2]}
                        // ]);
                        debugPrint(colorInfo.toString());
                        debugPrint(sized.toString());
                        setState(() {});
                      });

                    },
                    child: Container(
                      height: 70,
                      margin: const EdgeInsets.only(
                          bottom: 15, left: 20, right: 20),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromRGBO(174, 174, 174, 1),
                          ),
                          borderRadius: BorderRadius.circular(6)),
                      child: Stack(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              index < photoColor.length
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: Image.file(
                                          File((photoColor[index]).path),
                                          fit: BoxFit.cover),
                                    )
                                  : productModel
                                              .productColors![
                                                  index - photoColor.length]
                                              .productImages!
                                              .length !=
                                          0
                                      ? Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            child: CachedNetworkImage(
                                              imageUrl: IpAddress().ipAddress +
                                                  "/" +
                                                  productModel
                                                      .productColors![index -
                                                          photoColor.length]
                                                      .productImages!.last
                                                      .image
                                                      .toString(),
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
                                            ),
                                          ),
                                        )
                                      : Icon(Icons.access_time),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IntrinsicHeight(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, top: 10),
                                      child: Row(
                                        children: [
                                          Text(
                                            index < colorInfo.length
                                                ? colorInfo[index][0].toString()
                                                : productModel
                                                    .productColors![index -
                                                        colorInfo.length]
                                                    .colorNameTm!,
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
                                          // Text(
                                          //   "${index < colorInfo.length ? colorInfo[index][2] : productModel.productColors![index - colorInfo.length].productSizes[]} tmt",
                                          //   style: TextStyle(
                                          //       fontSize: 13,
                                          //       fontWeight: FontWeight.w500,
                                          //       color: Color.fromRGBO(
                                          //           97, 97, 97, 1)),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5, bottom: 10),
                                      child: Container(
                                        height: 30,
                                        width:
                                            MediaQuery.of(context).size.width -
                                                150,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, proindex) {
                                            return Container(
                                              width: 40,
                                              height: 20,
                                              margin: const EdgeInsets.only(
                                                  left: 5, top: 10),
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
                                              alignment: Alignment.center,
                                              child: Text(
                                                index < colorInfo.length
                                                    ? sized[index]["sizes"]
                                                        [proindex]["size"]
                                                    : productModel
                                                        .productColors![index -
                                                            colorInfo.length]
                                                        .productSizes![proindex]
                                                        .size
                                                        .toString(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14),
                                                textAlign: TextAlign.center,
                                              ),
                                            );
                                          },
                                          itemCount: index < colorInfo.length
                                              ? sized[index]["sizes"].length
                                              : productModel
                                                  .productColors![
                                                      index - colorInfo.length]
                                                  .productSizes!
                                                  .length,
                                        ),
                                      ))
                                ],
                              ),
                            ],
                          ),
                          Positioned(
                            right: 0,
                            top: 20,
                            child: const Padding(
                              padding: EdgeInsets.only(right: 20),
                              child: Icon(
                                Icons.arrow_forward,
                                color: Color.fromRGBO(174, 174, 174, 1),
                                size: 25,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                    childCount:
                        colorInfo.length + productModel.productColors!.length),
              )
            : SliverList(delegate: SliverChildListDelegate([])),
        SliverList(
            delegate: SliverChildListDelegate([
          InkWell(
            onTap: () {
              Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddColor(url: widget.url!,lan: widget.lan!,)))
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
            child: AddPhoto().addPhoto(widget.lan!.gornusGos,),
          ),
           Padding(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
            child: Text(
              widget.lan!.detalSuratgos,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
            ),
          ),
          detalsFileList.length != 0 || productModel.details!.length != 0
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
                      return Padding(
                        padding: const EdgeInsets.all(5),
                        child: index < detalsFileList.length
                            ? Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(6),
                                    child: Image.file(
                                      File(detalsFileList[index].path),
                                      fit: BoxFit.fill,
                                      width: 70,
                                      height: 70,
                                    ),
                                  ),
                                  Positioned(
                                    right: 0,
                                    child: InkWell(
                                        onTap: () {
                                          detalsFileList.removeAt(index);
                                          setState(() {});
                                        },
                                        child: Icon(
                                          Icons.remove_circle_outlined,
                                          color: Colors.red,
                                        )),
                                  ),
                                ],
                              )
                            : Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(6),
                                    child: CachedNetworkImage(
                                      imageUrl: IpAddress().ipAddress +
                                          "/" +
                                          productModel
                                              .details![
                                                  index - detalsFileList.length]
                                              .image
                                              .toString(),
                                      placeholder: (context, url) => Container(
                                          alignment: Alignment.center,
                                          child: CircularProgressIndicator(
                                            color: Colors.red,
                                          )),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.access_time),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Positioned(
                                    right: 0,
                                    child: InkWell(
                                        onTap: () {
                                          DeleteDetals().fetchAlbum(productModel
                                              .details![
                                                  index - detalsFileList.length]
                                              .detailId
                                              .toString());
                                          productModel.details!.removeAt(
                                              index - detalsFileList.length);

                                          setState(() {});
                                        },
                                        child: Icon(
                                          Icons.remove_circle,
                                          color: Colors.red,
                                        )),
                                  ),
                                ],
                              ),
                      );
                    },
                    itemCount:
                        productModel.details!.length + detalsFileList.length,
                  ),
                )
              : Container(),
          InkWell(
            onTap: () {
              DetalisFile();
            },
            child: AddPhoto().addPhoto(widget.lan!.suratgosmak),
          ),
          Container(
            width: double.infinity,
            height: 45,
            padding: EdgeInsets.only(right: 13, left: 10),
            margin: EdgeInsets.only(left: 26, right: 26, top: 20, bottom: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: const Color.fromRGBO(238, 238, 238, 1)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Text(
                  widget.lan!.stokda,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                Row(
                  children: [
                     Text(
                      widget.lan!.no,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    Switch(
                        activeColor: Colors.red,
                        value: checkSotk,
                        onChanged: (value) {
                          checkSotk = value;
                          setState(() {});
                        }),
                     Text(
                      widget.lan!.yes,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                  ],
                )
              ],
            ),
          ),
          InkWell(
              onTap: () {
                //_showToast();
                logInOpen(
                    context,
                    productModel.productId.toString(),
                    productModel.subcategory!.subcategoryId!,
                    productModel.category!.categoryCategoryId!);

              },
              child: BottomSendInfo().bottomSendInfo(context,widget.url!))
        ])),
      ],
    );
  }

  void logInOpen(
      BuildContext context, String id, String subCate, String catId) async {
    if (_logInKey.currentState!.validate()) {
      _logInKey.currentState!.save();
debugPrint(id.toString());
      await EditProductHTTP().createUser(
          maglummat[0][0],
          maglummat[1][0],
          maglummat[2][0],
          maglummat[3][0],
          maglummat[4][0],
          catId,
          subCate,
          widget.discount == false ? 0.toString() : maglummat[5][0],
          checkSotk == true ? "1" : "0",
          imageFileList,
          detalsFileList,
          colorInfo,
          photoColor,
          sized,
          id,
          widget.action,
          context,maglummat[6][0]);
      setState(() {});
    } else {
      setState(() {
        otomatikKontrol = true;
      });
    }
  }

  final ImagePicker imagePicker = ImagePicker();

  List imageFileList = [];

  void selectImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
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
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
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

  // _showToast() {
  //   Widget toast = Container(
  //     padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
  //     decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(10.0),
  //         color: Colors.red,
  //         boxShadow: [
  //           BoxShadow(
  //               color: Color.fromRGBO(44, 218, 82, 0.2),
  //               spreadRadius: 0,
  //               blurRadius: 3,
  //               offset: Offset(0, 0))
  //         ]
  //     ),
  //     child: Row(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         Icon(Icons.check_circle_outline,
  //           color: Colors.white,
  //         ),
  //         SizedBox(
  //           width: 15.0,
  //         ),
  //         Text("Garaşmagyňyzy haýyş edýärin",
  //           style: TextStyle(
  //               fontSize: 16,
  //               fontWeight: FontWeight.w600,
  //               color: Colors.white
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  //
  //
  //   fToast!.showToast(
  //     child: toast,
  //     gravity: ToastGravity.BOTTOM,
  //     toastDuration: Duration(seconds: 2),
  //   );
  //
  // }



}
