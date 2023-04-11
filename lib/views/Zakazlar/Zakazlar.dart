import 'package:dukanlar/Model/AllOrderModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../CategorChangeNoti.dart';
import '../../Database/Language/GetLanguage.dart';
import '../../Database/Language/LanguagePath.dart';
import '../../Database/Tokens.dart';
import '../../IpAddress.dart';
import '../../Model/LanguageModel.dart';
import 'Musderi.dart';
import 'package:http/http.dart' as http;

class Zakazlar extends StatefulWidget {
  @override
  State<Zakazlar> createState() => _ZakazlarState();
}

class _ZakazlarState extends State<Zakazlar> {
  String ip = IpAddress().ipAddress;

  int current_page = 0;

  String _token = "";
  late AllOrderModel _allOrderModel;
  List<Order> orders = [];
String status="";
  Future<bool> allProduct({bool isrefest = false, String a=""}) async {
    await Token().tokenDosyaOku().then((value) {
      _token = value;
    });

    if (isrefest) {
      current_page = 0;
    }
status=a;
    final response = await http.get(

        Uri.parse( a==""?"${ip}/seller/orders?offset=$current_page":"${ip}/seller/orders?offset=$current_page&status=$a"),
        headers: <String, String>{
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${_token}',
        });

    debugPrint(response.body);
    debugPrint(response.statusCode.toString());
    if (response.statusCode == 201) {
      _allOrderModel = allOrderModelFromJson(response.body);
      current_page = current_page + 10;
      setState(() {});
      if (isrefest) {
        orders=_allOrderModel.orders!;
      } else {
        orders.addAll(_allOrderModel.orders!);
      }

      return true;
    } else {
      throw false;
    }
  }

  final RefreshController refreshController =
      RefreshController(initialRefresh: true);
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
    return FutureBuilder(
        future: Language().fetchAlbum(context),
        builder: (BuildContext context, AsyncSnapshot<LanguageModel> lanData) {
          if (lanData.hasData) {
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title:  Text(
                  lanData.data!.sargyt,
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
              ),
              body: SmartRefresher(
                controller: refreshController,
                footer: const ClassicFooter(loadStyle: LoadStyle.HideAlways,loadingText: "",canLoadingText: "",),
                enablePullUp: true,
                onRefresh: () async {
                  final result = await allProduct(isrefest: true,a: status);
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
                child: CustomScrollView(
                  slivers: [
                    SliverList(
                        delegate: SliverChildListDelegate([
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                context: context,
                                builder: (context) {
                                  return Wrap(
                                    children: [
                                      InkWell(
                                        child:
                                        filter(Color.fromRGBO(39, 39, 39, 1),  lanData.data!.all),
                                        onTap: () async {
                                          await allProduct(isrefest: true, a: "");
                                          refreshController.requestRefresh();
                                          Navigator.pop(context);
                                        },
                                      ),
                                      InkWell(
                                          onTap: () async {
                                            await allProduct(isrefest: true, a: "Garashylyar");
                                            refreshController.requestRefresh();
                                            Navigator.pop(context);
                                          },
                                          child: filter(Color.fromRGBO(240, 159, 0, 1),
                                              lanData.data!.garas)),
                                      InkWell(
                                        onTap: ()async {
                                          await allProduct(isrefest: true, a: "Kabul edildi");
                                          refreshController.requestRefresh();
                                          Navigator.pop(context);
                                        },
                                        child: filter(Color.fromRGBO(86, 191, 49, 1),
                                            lanData.data!.kabulEt),
                                      ),
                                      InkWell(
                                        onTap: ()async {
                                          await allProduct(isrefest: true, a: "Gowshuryldy");
                                          refreshController.requestRefresh();
                                          Navigator.pop(context);
                                        },
                                        child: filter(Colors.blueAccent,
                                            url=="tm"?"Gowşuryldy":"Переданный"),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          await allProduct(isrefest: true, a: "Yatyryldy");
                                          refreshController.requestRefresh();
                                          Navigator.pop(context);
                                        },
                                        child: filter(Color.fromRGBO(255, 20, 29, 1),
                                            lanData.data!.kabulEtm),
                                      )
                                    ],
                                  );
                                },
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.all(20),
                              height: 50,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color.fromRGBO(174, 174, 174, 1)),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset("asset/logo/ahlisi.svg"),
                                   Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Text(
                                      lanData.data!.all,
                                      style: TextStyle(
                                          fontSize: 16, fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ])),
                    SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          return Container(
                            margin: const EdgeInsets.all(20),
                            height: 192,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color.fromRGBO(226, 226, 226, 1),
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(left: 5, right: 5),
                                      // padding: EdgeInsets.only(left: 5,right: 5),
                                      height: 25,
                                      width: MediaQuery.of(context).size.width*0.35,
                                      decoration: BoxDecoration(
                                          color: const Color.fromRGBO(232, 232, 232, 1),
                                          borderRadius: BorderRadius.circular(3)),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          // Text(
                                          //   DateFormat('M/d/y')
                                          //       .format(orders[index].createdAt),
                                          //   style: TextStyle(
                                          //       fontWeight: FontWeight.w400, fontSize: 13),
                                          // ),
                                          Text(
                                            orders[index].deliveryTime,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400, fontSize: 13),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      // padding: EdgeInsets.only(left: 5,right: 5),
                                      height: 25, width: 60,
                                      decoration: BoxDecoration(
                                          color: const Color.fromRGBO(232, 232, 232, 1),
                                          borderRadius: BorderRadius.circular(3)),
                                      child: Center(
                                        child: Text(
                                          "ID: ${orders[index].id}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w400, fontSize: 13),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, right: 5, top: 15, bottom: 15),
                                      child: SvgPicture.asset("asset/logo/user.svg"),
                                    ),
                                    Text(
                                      orders[index].userName,
                                      style: const TextStyle(
                                          fontSize: 13, fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: RichText(
                                      text: TextSpan(
                                          text: "Jemi baha:  ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13,
                                              color: const Color.fromRGBO(39, 39, 39, 1)),
                                          children: [
                                            TextSpan(
                                                text: "${orders[index].totalPrice} tmt",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 13,
                                                    color:
                                                    const Color.fromRGBO(97, 97, 97, 1))),
                                          ])),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: RichText(
                                      text: TextSpan(
                                          text: "Status: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13,
                                              color: const Color.fromRGBO(97, 97, 97, 1)),
                                          children: [
                                            TextSpan(
                                                text: "${orders[index].status}",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 13,
                                                    color:
                                                    const Color.fromRGBO(240, 158, 0, 1))),
                                          ])),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Musderi(
                                                address: orders[index].address,
                                                payment_type: orders[index].paymentType,
                                                status: orders[index].status,
                                                timeHour: orders[index].deliveryTime,
                                                phoneNumber: orders[index].userPhone,
                                                time: DateFormat('M/d/y')
                                                    .format(orders[index].createdAt),
                                                username: orders[index].userName,
                                                id: orders[index].orderId, product_id: orders[index].id.toString(),)));
                                  },
                                  child: Container(
                                    color: Color.fromRGBO(250, 250, 250, 1),
                                    width: MediaQuery.of(context).size.width,
                                    height: 50,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 15, right: 20),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            orders[index].address,
                                            style: TextStyle(
                                                fontSize: 15, fontWeight: FontWeight.w400),
                                          ),
                                          Container(
                                            width: 30,
                                            height: 30,
                                            decoration: BoxDecoration(
                                                color: Color.fromRGBO(226, 226, 226, 1),
                                                borderRadius: BorderRadius.circular(5)),
                                            child: Icon(
                                              Icons.arrow_forward_ios,
                                              size: 20,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        }, childCount: orders.length)),
                  ],
                ),
              ),
            );

          } else {
            return Center(child: CircularProgressIndicator(color: Colors.red,));
          }
        });

  }

  filter(Color colors, String info) {
    return Container(
      width: double.infinity,
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Color.fromRGBO(174, 174, 174, 1))),
      child: Center(
        child: Text(
          info,
          style: TextStyle(
              fontWeight: FontWeight.w500, fontSize: 16, color: colors),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
