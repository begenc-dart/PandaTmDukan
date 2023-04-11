import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../IpAddress.dart';

class OneProduct extends StatefulWidget {
  List images;
  String title;
  String price;
  VoidCallback press;
  String discount;
  String priceOld;
  bool isNew;

  OneProduct(
      {required this.images,
      required this.title,
      required this.price,
      required this.press,
      required this.discount,
      required this.priceOld,
      required this.isNew});

  @override
  State<OneProduct> createState() => _OneProductState();
}

class _OneProductState extends State<OneProduct> {
  int _current = 0;

  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Color.fromRGBO(174, 174, 174, 1)),
          borderRadius: BorderRadius.circular(5),color: Colors.white60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Stack(
              children: [
                Column(
                  children: [
                    CarouselSlider.builder(
                      itemCount: widget.images.length,
                      options: CarouselOptions(
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        },
                        height: 140.0,
                        aspectRatio: 0,
                        viewportFraction: 1,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: false,
                        //autoPlayInterval: Duration(seconds: 10),
                        //autoPlayAnimationDuration:
                        //Duration(milliseconds: 700),
                        // autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                      ),
                      itemBuilder:
                          (BuildContext context, int itemIndex, int pageViewIndex) {
                        return Container(
                          height: double.infinity,
                          width: double.infinity,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: widget.images.length != 0
                                ? CachedNetworkImage(
                                    imageUrl: "${IpAddress().ipAddress}/" +
                                        widget.images[itemIndex].image,
                                    placeholder: (context, url) => Container(
                                        alignment: Alignment.center,
                                        child: CircularProgressIndicator(
                                          color: Colors.red,
                                        )),
                                    errorWidget: (context, url, error) =>
                                        Image.asset("asset/images/p.jpg"),
                                    fit: BoxFit.fill,
                                  )
                                : Container(
                              width: double.infinity,
                              height: 140.0,
                              color: Colors.grey,
                            ),
                          ),
                        );
                      },
                    ),
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: widget.images.map((url) {
                        int index =
                        widget.images.indexOf(url);
                        return Container(
                          width: 6.0,
                          height: 6.0,
                          margin: EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 3.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _current == index
                                ? Color.fromRGBO(
                                0, 0, 0, 0.9)
                                : Color.fromRGBO(
                                0, 0, 0, 0.4),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),

                Positioned(
                  top: widget.discount != 0.toString()&&widget.discount != null.toString() ? -5 : -25,
                  left: -33,
                  child: RotationTransition(
                    turns: new AlwaysStoppedAnimation(15 / 360),
                    child: Container(
                      width: 63,
                      height: 38,
                      alignment: Alignment.bottomRight,
                      padding: EdgeInsets.only(right: 5, bottom: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromRGBO(255, 199, 0, 1)),
                      child: Text(
                        "New",
                        style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.w700,
                            color: Color.fromRGBO(37, 37, 37, 1)),
                      ),
                    ),
                  ),
                ),
                widget.discount != 0.toString()&&widget.discount != null.toString()
                    ? Positioned(
                        top: -20,
                        left: -25,
                        child: RotationTransition(
                          turns: new AlwaysStoppedAnimation(15 / 360),
                          child: Container(
                            width: 63,
                            height: 38,
                            alignment: Alignment.bottomRight,
                            padding: EdgeInsets.only(right: 5, bottom: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color.fromRGBO(37, 37, 37, 1),
                            ),
                            child: Text(
                              "-${widget.discount}%",
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    : Container()
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only( bottom: 5,left: 8),
            child: Text(
              widget.title,
              maxLines: 1,
              style: TextStyle(
                fontSize: 14,
                color: Color.fromRGBO(39, 39, 39, 1),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8,bottom: 8,right: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,

                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(widget.price.toString(),
                            style: TextStyle(
                              fontSize: 17,
                              color: Color.fromRGBO(39, 39, 39, 1),
                              fontWeight: FontWeight.w700,
                            )),
                        Container(
                          width: 29,
                          height: 13,
                          margin: EdgeInsets.only(left: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Color.fromRGBO(222, 222, 222, 1)),
                          child: Center(
                              child: Text(
                            "TMT",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.black54,
                              fontWeight: FontWeight.w900,
                            ),
                            textAlign: TextAlign.center,
                          )),
                        )
                      ],
                    ),
                    widget.priceOld!=0.toString()?  Expanded(
                      flex: 1,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        textDirection: TextDirection.rtl,
                        children: [

                          Flexible(
                            child: Text(
                              "",
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w900,
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: Colors.red),
                              textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis, maxLines: 1,
                            ),
                          ),
                          Flexible(
                            child: Text(widget.priceOld.toString()+"TMT",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w700,
                                  decoration: TextDecoration.lineThrough,

                                  decorationColor: Colors.red),overflow: TextOverflow.ellipsis, maxLines: 1,),
                          ),
                        ],
                      ),
                    ):Flexible(child: Container()),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
/*
* Positioned(
            left: 15,
            top: 0,
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: img.map((url) {
                int index = img.indexOf(url);
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 3.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.red),
                      shape: BoxShape.circle,
                      color: currentPos == index
                          ? Colors.white
                          : Colors.amber
                  ),
                );
              }).toList(),
            ),),
* */
