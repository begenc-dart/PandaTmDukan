import 'package:cached_network_image/cached_network_image.dart';
import 'package:dukanlar/views/add_product.dart';
import 'package:flutter/material.dart';

import '../../../IpAddress.dart';
import '../../../Model/CategoriyaQT.dart';
import '../../../Model/LanguageModel.dart';

class Subcategoriya extends StatefulWidget {
  List<Subcategory> subCate;
  CategoriyaModel cate;
LanguageModel lan;
String url;
  Subcategoriya({required this.subCate, required this.cate,required this.lan,required this.url});

  @override
  _SubcategoriyaState createState() => _SubcategoriyaState();
}

class _SubcategoriyaState extends State<Subcategoriya> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height *0.8369,
      width: MediaQuery.of(context).size.width - 110,
      color: Colors.white,
      child: GridView.extent(
        maxCrossAxisExtent: 100,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: 0.9,
        shrinkWrap: true,
        children: List.generate(
          widget.subCate.length,
          (index) {
            return Container(
              height: 150,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddProduct(
                                subcatId: widget.subCate[index].subcategoryId,
                                subcatname: widget.url=="tm"?widget.subCate[index].nameTm:widget.subCate[index].nameRu,
                                cateId: widget.cate.categoryId,
                                catname: widget.url=="tm"?widget.cate.nameTm:widget.cate.nameRu, lan: widget.lan,url: widget.url,
                              )));
                },
                child: Column(
                  children: [
                    widget.subCate[index].image!=null?ClipRRect(
                     borderRadius: BorderRadius.circular(10), child: CachedNetworkImage(
                        height: 60,
                        width: 60,
                        imageUrl: "${IpAddress().ipAddress}/" +
                            widget.subCate[index].image!,
                        placeholder: (context, url) => Container(
                            alignment: Alignment.center,
                            child: Container()),
                        errorWidget: (context, url, error) =>
                            Image.asset("asset/images/p.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ):Image.asset("asset/images/p.jpg"),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                       widget.url=="tm"? widget.subCate[index].nameTm:widget.subCate[index].nameRu,
                        maxLines: 2,

                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 10,
                            color: Color.fromRGBO(107, 107, 108, 1)),textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
