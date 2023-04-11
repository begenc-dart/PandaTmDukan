import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dukanlar/views/components/dukan/oneProduct.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../Database/Tokens.dart';
import '../../IpAddress.dart';
import '../../Model/LanguageModel.dart';
import '../../server/AddProduct.dart';
import '../EditProduct/EditProduct.dart';
import 'SearchProductModel.dart';
class ProductGrid extends StatefulWidget {
  // List<ActionProduct>? pro;
  LanguageModel lan;
  String url;
  String keys;
  ProductGrid({required this.keys,required this.lan,required this.url});

  @override
  State<ProductGrid> createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  List photoProduct = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRp0-c7PZi3hJulH_fnbH3UfG_4iX6ULwsuKQ&usqp=CAU",
    "https://media.dnd.wizards.com/ToD_1280x960_Wallpaper.jpg",
    "https://wallpapercave.com/wp/wp5187178.jpg"
  ];

  bool check = false;
  int page = 0;
  String token="";
  String ip = IpAddress().ipAddress;
  String checkLike = "";
  List<Product> prod = [];
  int current_page = 0;
  late SearchModel _searchModel;
  final RefreshController refreshController =
  RefreshController(initialRefresh: true);
  int b=0;
  Future<bool> fetchAlbum({bool isrefest = false, int a=0}) async {
    await Token().tokenDosyaOku().then((value) {
      token = value;
    });

    if (isrefest) {
      current_page = 0;
    }

    final response = await http.get(Uri.parse(
"$ip/seller/products/?offset=$current_page&keyword=${widget.keys}&limit=10"),
      headers:<String, String>{
        "Content-Type": "application/json",
        'Authorization': 'Bearer ${token}',
      } ,);
    b=a;
    debugPrint(response.body.toString() + 'dfsdf');
    debugPrint(a.toString()+"dsf");
    if (response.statusCode == 200) {

      _searchModel = searchModelFromJson(response.body);


      if (isrefest) {
        prod = _searchModel.products!=null?_searchModel.products:<Product>[];

      } else {
        prod.addAll(_searchModel.products);

      }

      current_page = current_page + 10;

      setState(() {});
      return true;
    } else {
      return false;
    }
  }
  int grvalue = 1;
  @override
  List a=[];
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 1.3;
    // final productIndex = Provider.of<ProductIndex>(context);
    return  SmartRefresher(

      controller: refreshController,
      enablePullUp: true,
      onRefresh: () async {
        final result = await fetchAlbum(isrefest: true,a: b);
        if (result) {
          refreshController.refreshCompleted();
        } else {
          refreshController.refreshFailed();
        }
      },
      onLoading: () async {
        final result = await fetchAlbum();
        if (result) {
          refreshController.loadComplete();
        } else {
          refreshController.loadFailed();
        }
      },
      child: CustomScrollView(
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
                                  lan: widget.lan,
                                  url: widget.url,
                                  newProduct: false,
                                  prodId: prod[index].productId,
                                  discount: prod[index].discount!=null&&prod[index].discount!=0?true:false, action: prod[index].isAction!=null&&prod[index].isAction!=false?true:false,
                                )));
                      },
                      child: OneProduct(
                        images: prod[index].images,
                        title:widget.url=="tm"? prod[index].nameTm:prod[index].nameRu,
                        price:prod[index].price!=null.toString()? prod[index].price!.toStringAsFixed(1):"",
                        press: () {},
                        discount: prod[index].discount.toString(),
                        priceOld:prod[index].priceOld!=null? prod[index].priceOld!.toStringAsFixed(1):0.toString(),
                        isNew: prod[index].isNew,
                      ),
                    ),
                  );
                },
                childCount: prod.length,
              ),
              gridDelegate:  SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 250, //210 - 260
                childAspectRatio: 0.8,
              )),
        ],
      ),
    );
  }
}
