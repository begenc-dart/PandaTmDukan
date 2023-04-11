
import 'package:dukanlar/views/EditProduct/EditProduct.dart';

import 'package:flutter/material.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:http/http.dart' as http;
import '../Database/Tokens.dart';
import '../IpAddress.dart';
import '../Model/CategoriyaProduct.dart';
import '../Model/LanguageModel.dart';
import 'addDetail.dart';
import 'components/dukan/oneProduct.dart';

class AddProduct extends StatefulWidget {
  String subcatId;
  String cateId;
  String catname;
  String subcatname;
  LanguageModel lan;
  String url;
  AddProduct(
      {required this.cateId,
      required this.catname,
      required this.subcatId,
      required this.subcatname,required this.lan,required this.url});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  List<String> imgs = [
    "asset/images/p.jpg",
    "asset/images/p.jpg",
    "asset/images/p.jpg",
  ];

  final RefreshController refreshController =
  RefreshController(initialRefresh: true);
  String token="";
  late int current_page;
  String ip=IpAddress().ipAddress;
  late List<CategoriyaProduct> _subCategoriyaProduct;
  List<CategoriyaProduct> prod=[];
  Future<bool> fetchAlbum({bool isrefest = false,}) async {
    await Token().tokenDosyaOku().then((value) {
      token = value;
    });


    if (isrefest) {
      current_page = 0;
    }

    final response = await http.get(Uri.parse(
        "$ip/seller/sub-categories/products/${widget.subcatId}?offset=$current_page&limit=10"),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${token}',
        }

    );
    debugPrint(response.body.toString() + 'dfsdf');

    if (response.statusCode == 200) {
      (response.statusCode.toString());
      _subCategoriyaProduct = categoriyaProductFromJson(response.body);

      (response.statusCode.toString());
      if (isrefest) {
        prod = _subCategoriyaProduct;
      } else {
        prod.addAll(_subCategoriyaProduct);
      }
      ("new");
      current_page = current_page + 10;

      setState(() {

      });
      return true;
    } else {
      return false;
    }
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 1.3;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.subcatname),
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color.fromRGBO(239, 239, 239, 1)),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Icon(Icons.arrow_back_ios),
            ),
          ),
        ),
      ),
      body: SmartRefresher(
        controller: refreshController,
        enablePullUp: true,
        onRefresh: () async {
          final result = await fetchAlbum(isrefest: true,);
          if (result) {
            refreshController.refreshCompleted();
          } else {
            refreshController.refreshFailed();
          }
        },
        onLoading: () async {
          final result = await  fetchAlbum();
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
                        onTap: () {},
                        child: slideAndNewProducts(index, () {}, context),
                      ),
                    );
                  },
                  childCount: prod.length+1,
                ),
                gridDelegate:  SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 250, //210 - 260
                  childAspectRatio: 0.8,
                )),
          ],
        ),
      ),
    );
  }

  Widget slideAndNewProducts(
      int index, VoidCallback press, BuildContext context) {


    if (index == 0) {
      return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (contex) => AddProductDetail(
                          subcatId: widget.subcatId,
                          catname: widget.catname,
                          cateId: widget.cateId,
                          subcatname: widget.subcatname,newProduct: true, prodId: "", lan: widget.lan, url: widget.url,

                        )));
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Color.fromRGBO(174, 174, 174, 1)),
                borderRadius: BorderRadius.circular(5)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.add_circle_outline,
                  size: 50,
                ),
                Text(
                  widget.lan.addTow,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                )
              ],
            ),
          ));
    } else {
      return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (contex) => EditProductResult(
                 url:widget.url,lan: widget.lan,  newProduct: false, prodId: prod[index-1].productId!, discount: prod[index-1].discount!=null&&prod[index-1].discount!=0?true:false, action: prod[index-1].isAction!=null&&prod[index-1].isAction!=false?true:false,
                  )));
        },
        child: OneProduct(
          images: prod[index-1].images!,
          title: widget.url=="tm"?prod[index-1].nameTm!.toString():prod[index-1].nameRu!.toString(),
          price: prod[index-1].price!=null? prod[index-1].price!.toStringAsFixed(1):"",
          press: () {}, discount: prod[index-1].discount.toString(), priceOld:prod[index-1].priceOld!=null? prod[index-1].priceOld!.toStringAsFixed(1):"", isNew:  prod[index-1].isNew!,
        ),
      );
    }
  }
}
