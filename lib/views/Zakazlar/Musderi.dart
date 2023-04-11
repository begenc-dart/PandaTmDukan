import 'package:cached_network_image/cached_network_image.dart';
import 'package:dukanlar/CategorChangeNoti.dart';
import 'package:dukanlar/server/Products/OrderStatus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../IpAddress.dart';
import '../../Model/OrderHistoryStatus.dart';

class Musderi extends StatelessWidget {
  String time, timeHour, payment_type, phoneNumber, status, address,username,id,product_id;

  Musderi(
      {Key? key,
      required this.address,
        required this.username,
      required this.status,
      required this.time,
      required this.payment_type,
      required this.phoneNumber,
      required this.timeHour,required this.id,required this.product_id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<LanguageNot>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(239, 239, 239, 1),
                  borderRadius: BorderRadius.circular(5),
                ),
                alignment: Alignment.center,
                child: const Center(
                  child: Icon(Icons.arrow_back_ios),
                ),
              ),
            ),
             Padding(
              padding: EdgeInsets.only(left: 20),
              child:  Text(themeProvider.sana=="tm"?"Sargyt: $product_id":"Заказ: $product_id"),
            ),
          ],
        ),
      ),
      body: FutureBuilder(
      future: OrderStatus().fetchAlbum(id),
      builder: (context, AsyncSnapshot<OrderHistory> snapshot) {
        if(snapshot.hasData){
          return ListView(
            children: [
              Container(
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    border: Border.all(color: const Color.fromRGBO(226, 226, 226, 1))),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      // padding: EdgeInsets.only(left: 5,right: 5),
                      height: 25,
                      width: 130,
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(232, 232, 232, 1),
                          borderRadius: BorderRadius.circular(3)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:  [

                          Text(
                            timeHour,
                            style: const TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 13),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text(
                        username,
                        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 15),
                      child: RichText(
                          text:  TextSpan(
                              text: themeProvider.sana=="tm"?"Töleg:  ":"Оплата: ",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                  color: Color.fromRGBO(39, 39, 39, 1)),
                              children: [
                                TextSpan(
                                    text: payment_type,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13,
                                        color: Color.fromRGBO(97, 97, 97, 1))),
                              ])),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 20),
                      child: RichText(
                          text:  TextSpan(
                              text: "Status: ",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                  color: Color.fromRGBO(97, 97, 97, 1)),
                              children: [
                                TextSpan(
                                    text: status,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13,
                                        color: Color.fromRGBO(240, 158, 0, 1))),
                              ])),
                    ),
                    Container(
                      height: 40,
                      width: 260,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color.fromRGBO(235, 235, 235, 1)),
                      child: Center(
                        child: Text(
                          address,
                          style:
                          const TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20, bottom: 25),
                padding: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                    border: Border.all(color: const Color.fromRGBO(226, 226, 226, 1))),
                child: Column(
                  children: List.generate(snapshot.data!.orderProducts==null?0:snapshot.data!.orderProducts!.length, (index) {
                    return Container(
                      
                      margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(243, 243, 243, 1),
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CachedNetworkImage(
                                imageUrl:
                                "${IpAddress().ipAddress}/" +
                                    snapshot.data!.orderProducts![index].image,
                                placeholder: (context, url) =>
                                    Container(
                                        alignment:
                                        Alignment.center,
                                        child:
                                        CircularProgressIndicator(
                                          color: Colors.red,
                                        )),
                                errorWidget: (context, url,
                                    error) =>
                                    Image.asset(
                                        "asset/images/p.jpg"),
                                fit: BoxFit.fill,
                                width: 70,
                                height: 70,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:  [
                                    Container(
                                      width: MediaQuery.of(context).size.width*0.4,
                                      child: Text(
                                        themeProvider.sana=="tm"?  snapshot.data!.orderProducts![index].nameTm:snapshot.data!.orderProducts![index].nameRu,

                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    // Padding(
                                    //   padding: EdgeInsets.only(top: 9),
                                    //   child: Text(
                                    //     snapshot.data!.orderProducts![index].,
                                    //     style: TextStyle(
                                    //         fontSize: 14,
                                    //         fontWeight: FontWeight.w500),
                                    //   ),
                                    // )
                                  ],
                                ),
                              )
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               Padding(
                                padding: EdgeInsets.only(top: 7, right: 5),
                                child: Text(
                    snapshot.data!.orderProducts![index].price.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700, fontSize: 15),
                                ),
                              ),
                              Container(
                                height: 70,
                                margin: const EdgeInsets.only(right: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 1, horizontal: 3),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(3),
                                          color: const Color.fromRGBO(222, 222, 222, 1)),
                                      child: const Text(
                                        "manat",
                                        style:  TextStyle(
                                            fontSize: 8,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color.fromRGBO(41, 41, 41, 1),
                                              width: 0.8),
                                          borderRadius: BorderRadius.circular(2)),
                                      child:  Text(
                                        "x${snapshot.data!.orderProducts![index].quantity}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  }),
                ),
              )
            ],
          );
        }
        else{
          return CircularProgressIndicator();
        }
    }
      ),
    );
  }
}
