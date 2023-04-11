import 'package:flutter/material.dart';

class Toast {
  void showToastDelet(BuildContext context,String text) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        // margin: EdgeInsets.only(bottom: 120),
        duration: Duration(milliseconds: 1000),
        content: Container(width:MediaQuery.of(context).size.width,child: Text(text.toString())),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}