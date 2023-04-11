import 'package:flutter/material.dart';

class BottomSendInfo{
  bottomSendInfo(BuildContext context,String url){
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 20, 29, 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child:  Center(
        child:  Text(
          url =="tm"?"Dowam et":"Продолжать",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Colors.white),
        ),
      ),
    );
  }
}