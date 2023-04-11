import 'package:dukanlar/views/Search/SearchProduct.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Model/LanguageModel.dart';


class CustomSearchDelegate extends SearchDelegate {
  LanguageModel lan;
  String url;
  CustomSearchDelegate({required this.url,required this.lan}): super(
    searchFieldLabel: "",
    keyboardType: TextInputType.text,
    textInputAction: TextInputAction.search,
    searchFieldStyle: TextStyle(
        color: Color.fromARGB(178, 255, 255, 255),
        fontWeight: FontWeight.bold),
  );

  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor:  const Color.fromRGBO(250, 250, 250, 1),
      canvasColor: const Color.fromRGBO(255, 255, 255, 1),
      textTheme: const TextTheme(
        // Use this to change the query's text style
        headline6: TextStyle(
            fontWeight: FontWeight.w400, fontSize: 14, color: Color.fromRGBO(153, 153, 153, 1)),
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        iconTheme: IconThemeData(
            color: Color.fromRGBO(153, 153, 153, 1)),
        backgroundColor:  Color.fromRGBO(255, 255, 255, 1),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        contentPadding: EdgeInsets.all(15),
        focusColor: Colors.white,

        enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        filled: true,
        fillColor: Color.fromRGBO(246, 246, 246, 1),

        // Use this change the placeholder's text style
        hintStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Color.fromRGBO(153, 153, 153, 1)),
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.red),
    );
  }

  bool check = false;



  // first overrite to clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.close),
      )
    ];
  }

  // second overrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(
        Icons.arrow_back,
        color: Color.fromRGBO(41, 41, 41, 1),
      ),
    );
  }

  // third overrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    check = true;
    // var box=Hive.box("search");

    // box.add(query);

    return ProductGrid( keys: query,lan: lan,url: url,);
  }

  // last overrite to show the
  // quering process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    check = false;

    // return "query.length == 0 ? Related() : Suggestion(query);"
    // return Related();
    return Container();
  }
}
