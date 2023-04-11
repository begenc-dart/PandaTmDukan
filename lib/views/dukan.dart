import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dukanlar/Model/ProductsModel.dart';
import 'package:dukanlar/server/PostDiscount.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../CategorChangeNoti.dart';
import '../Database/Language/GetLanguage.dart';
import '../Database/Language/LanguagePath.dart';
import '../Database/Tokens.dart';
import '../Database/count.dart';
import '../IpAddress.dart';
import '../Model/LanguageModel.dart';
import '../Model/ProductModel.dart';
import '../server/Get_Me.dart';
import 'EditProduct/EditProduct.dart';
import 'components/dukan/oneProduct.dart';
import 'package:http/http.dart' as http;

class Dukan extends StatefulWidget {
  @override
  State<Dukan> createState() => _DukanState();
}

class _DukanState extends State<Dukan> {
  List<String> img = [
    "asset/images/p.jpg",
    "asset/images/p.jpg",
    "asset/images/p.jpg",
  ];

  String? _token;

  String checkLike = "";

  late ProductsMainPageModel randomProduct;

  String ip = IpAddress().ipAddress;

  int current_page = 0;

  List<Product> products = [];

  Future<bool> allProduct({bool isrefest = false}) async {
    await Token().tokenDosyaOku().then((value) {
      _token = value;

    });
debugPrint(_token);
    if (isrefest) {
      current_page = 0;
    }

    final response = await http.get(
        Uri.parse("${ip}/seller/products?offset=$current_page&limit=10"),
        headers: <String, String>{
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${_token}',
        });

    debugPrint(current_page.toString());
    if (response.statusCode == 200) {
      randomProduct = productsMainPageModelFromJson(response.body);

      if (isrefest) {
        products.clear();
        products.addAll(randomProduct.products);
      } else {
        products.addAll(randomProduct.products);
      }
      current_page = current_page + 10;
      setState(() {});
      return true;
    } else {
      throw false;
    }
  }

  bool discountcheck = false;
  final RefreshController refreshController =
      RefreshController(initialRefresh: true);
  String radioItem = '0';
  @override
  Future<ProductModel>? productModel;
  String zakaz = "";

  void initState() {
    // TODO: implement initState
    postGetMe();
language();
    super.initState();
  }
  String url="";
language()async{
  await LanguageFileRead().then((value) {
    url = value;
  });
}
  postGetMe() async {
    await PostGetMe().fetchAlbum().then((value) {
      zakaz = value.nameTm!;
    });
    return zakaz;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 1.3;

    Future<ProductModel>? productModel;

    final themeProvider = Provider.of<MainPageProv>(context);
    radioItem = themeProvider.sana.toString();
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Image.asset("asset/images/1.png",width: 50,height: 50,),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(zakaz),
              )
            ],
          ),
          actions: [
            InkWell(
              child: Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color.fromRGBO(239, 239, 239, 1)),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Center(
                    child: Text(
                      themeProvider.sana.toString() + "%",
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              onTap: () async {
                showDialog(
                  context: context,
                  builder: (context) {
                    return StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                      return AlertDialog(
                        backgroundColor: Colors.white,
                        // contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        title: Column(
                          children: [
                            RadioListTile(
                              visualDensity: const VisualDensity(
                                  horizontal: VisualDensity.minimumDensity,
                                  vertical: VisualDensity.minimumDensity),
                              // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              // contentPadding: EdgeInsets.only(top: 10,b),
                              controlAffinity: ListTileControlAffinity.trailing,
                              groupValue: radioItem,
                              title: Text(
                                '0%',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                              value: '0',
                              onChanged: (val) async {
                                await PostDiscount().createUser("0");
                                radioItem = val.toString();
                                themeProvider.sana = 0;
                                refreshController.requestRefresh();
                                Navigator.pop(context);
                                setState(() {});
                              },
                            ),
                            RadioListTile(
                              visualDensity: const VisualDensity(
                                  horizontal: VisualDensity.minimumDensity,
                                  vertical: VisualDensity.minimumDensity),
                              controlAffinity: ListTileControlAffinity.trailing,
                              groupValue: radioItem,
                              title: Text(
                                '10%',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                              value: '10',
                              onChanged: (val) async {
                                await PostDiscount().createUser("10");
                                radioItem = val.toString();
                                themeProvider.sana = 10;
                                refreshController.requestRefresh();
                                setState(() {});
                                Navigator.pop(context);
                              },
                            ),
                            RadioListTile(
                              visualDensity: const VisualDensity(
                                  horizontal: VisualDensity.minimumDensity,
                                  vertical: VisualDensity.minimumDensity),
                              controlAffinity: ListTileControlAffinity.trailing,
                              groupValue: radioItem,
                              title: Text(
                                '20%',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                              value: '20',
                              onChanged: (val) async {
                                await PostDiscount().createUser("20");
                                radioItem = val.toString();
                                themeProvider.sana = 20;
                                refreshController.requestRefresh();
                                setState(() {});
                                Navigator.pop(context);
                              },
                            ),
                            RadioListTile(
                              visualDensity: const VisualDensity(
                                  horizontal: VisualDensity.minimumDensity,
                                  vertical: VisualDensity.minimumDensity),
                              controlAffinity: ListTileControlAffinity.trailing,
                              groupValue: radioItem,
                              title: Text(
                                '30%',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                              value: '30',
                              onChanged: (val) async {
                                await PostDiscount().createUser("30");
                                // await PostDiscount().createUser("50");
                                refreshController.requestRefresh();
                                themeProvider.sana = 20;
                                await allProduct(isrefest: true);
                                setState(() {
                                  radioItem = val.toString();
                                });
                                Navigator.pop(context);
                              },
                            ),
                            RadioListTile(
                              visualDensity: const VisualDensity(
                                  horizontal: VisualDensity.minimumDensity,
                                  vertical: VisualDensity.minimumDensity),
                              controlAffinity: ListTileControlAffinity.trailing,
                              groupValue: radioItem,
                              title: Text(
                                '40%',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                              value: '40',
                              onChanged: (val) async {
                                await PostDiscount().createUser("40");
                                await allProduct(isrefest: true);
                                setState(() {
                                  radioItem = val.toString();
                                });
                                themeProvider.sana = 40;
                                refreshController.requestRefresh();
                                Navigator.pop(context);
                              },
                            ),
                            RadioListTile(
                              visualDensity: const VisualDensity(
                                  horizontal: VisualDensity.minimumDensity,
                                  vertical: VisualDensity.minimumDensity),
                              controlAffinity: ListTileControlAffinity.trailing,
                              groupValue: radioItem,
                              title: Text(
                                '50%',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                              value: '50',
                              onChanged: (val) async {
                                await PostDiscount().createUser("50");
                                await allProduct(isrefest: true);
                                setState(() {
                                  radioItem = val.toString();
                                  themeProvider.sana = 50;
                                  refreshController.requestRefresh();
                                });

                                Navigator.pop(context);
                              },
                            ),
                            RadioListTile(
                              visualDensity: const VisualDensity(
                                  horizontal: VisualDensity.minimumDensity,
                                  vertical: VisualDensity.minimumDensity),
                              controlAffinity: ListTileControlAffinity.trailing,
                              groupValue: radioItem,
                              title: Text(
                                '60%',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                              value: '60',
                              onChanged: (val) async {
                                await PostDiscount().createUser("60");
                                await allProduct(isrefest: true);
                                radioItem = val.toString();
                                refreshController.requestRefresh();
                                themeProvider.sana = 60;
                                setState(() {});
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      );
                    });
                  },
                );
              },
            )
          ],
        ),
        body: FutureBuilder(
          future: Language().fetchAlbum(context),
          builder: (context, AsyncSnapshot<LanguageModel> snapshot) {
            if (snapshot.hasData) {
              return SmartRefresher(
                controller: refreshController,
                enablePullUp: true,
                header: ClassicHeader(refreshStyle: RefreshStyle.UnFollow,),

                onRefresh: () async {
                  final result = await allProduct(isrefest: true);
                  if (result) {
                    refreshController.refreshCompleted();

                    setState(() {});
                  } else {
                    refreshController.refreshFailed();
                  }
                },
                onLoading: () async {
                  final result = await allProduct();
                  setState(() {});
                  if (result) {
                    refreshController.loadComplete();
                  } else {
                    refreshController.loadFailed();
                  }
                },
                child: sellerPage(refreshController.isLoading,snapshot.data!),
                footer: const ClassicFooter(loadStyle: LoadStyle.HideAlways,canLoadingText: "",),
              );
            } else {
              debugPrint(snapshot.data.toString());
              return Container();
            }
          },
        ));
  }

  sellerPage(bool check,LanguageModel lan) {
    // final product = Provider.of<ProductNoti>(context);
    return CustomScrollView(
      slivers: [
        SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (contex) => EditProductResult(
                                    newProduct: false,
                                    prodId: products[index].productId,
                                    discount:
                                        products[index].discount != null &&
                                                products[index].discount != 0
                                            ? true
                                            : false,
                                    action: products[index].isAction != null &&
                                            products[index].isAction == true
                                        ? true
                                        : false, lan:lan, url: url ,
                                  )));
                    },
                    child: OneProduct(
                      images: products[index].images!,
                      title: url=="tm"?products[index].nameTm:products[index].nameRu,
                      price: products[index].price != null
                          ? products[index].price!.toStringAsFixed(1)
                          : "",
                      press: () {},
                      discount: products[index].discount.toString(),
                      priceOld: products[index].priceOld != null &&
                              products[index].discount != 0
                          ? products[index].priceOld!.toStringAsFixed(1)
                          : 0.toString(),
                      isNew: products[index].isNew,
                    ),
                  ),
                );
              },
              childCount: products.length,
            ),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 250, //210 - 260
              childAspectRatio: 0.8,
            )),
      ],
    );
  }
}
