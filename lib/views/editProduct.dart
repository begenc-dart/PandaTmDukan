import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EditProduct extends StatefulWidget {
  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  int currentPos = 0;
  bool change = false;
  String selectedCategory = "l";
  List images = [
    "asset/images/p.jpg",
    "asset/images/p.jpg",
  ];

  @override
  void initState() {
    super.initState();
  }

  bool checkStok = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Taze haryt gosmak"),
          leading: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: const Color.fromRGBO(239, 239, 239, 1)),
            child: const Padding(
              padding: EdgeInsets.all(5.0),
              child: Icon(Icons.arrow_back_ios),
            ),
          ),
          actions: [
            Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.red)),
              child: Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Icon(
                      Icons.delete_outline,
                      color: Color.fromRGBO(116, 116, 116, 1),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "Ocurmek",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        body: Stack(
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              child: CustomScrollView(
                slivers: [
                  SliverList(
                      delegate: SliverChildListDelegate([
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// big picture
                        Stack(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.45,
                              decoration: BoxDecoration(
                                // color: Colors.greenAccent,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Color.fromRGBO(0, 0, 0, 0.15),
                                      spreadRadius: 0,
                                      blurRadius: 3,
                                      offset: Offset(0, 0))
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.asset(
                                  "asset/images/p.jpg",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                                right: 5,
                                bottom: 5,
                                child: Container(
                                  height: 30,
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white),
                                  child: Row(
                                    children: const [
                                      Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Icon(
                                          Icons.delete_outline,
                                          color:
                                              Color.fromRGBO(116, 116, 116, 1),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Text(
                                          "Suraty ocurmek",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black),
                                        ),
                                      )
                                    ],
                                  ),
                                ))
                          ],
                        ),

                        /// picture list
                        Container(
                          //color: Colors.yellowAccent,
                          height: 70,
                          margin: const EdgeInsets.only(
                              right: 10, top: 8, bottom: 15),
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: images.map((url) {
                              int index = images.indexOf(url);
                              // debugPrint(index.toString());
                              return Container(
                                height: 70,
                                width: 70,
                                margin:
                                    const EdgeInsets.only(left: 8, right: 2),
                                decoration: BoxDecoration(
                                    //color: Colors.greenAccent,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: index == url
                                            ? Colors.red
                                            : const Color.fromRGBO(
                                                239, 239, 239, 1))),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.asset(
                                    images[index],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),

                        Container(
                          margin: const EdgeInsets.only(top: 15, bottom: 10),
                          child: const Text(
                            "Harydyn ady (Turkmence)",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400),
                          ),
                        ),

                        TextFormField(
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: Color.fromRGBO(239, 239, 239, 1))),
                            contentPadding: const EdgeInsets.all(12),
                          ),
                        ),

                        Container(
                          margin: const EdgeInsets.only(top: 15, bottom: 10),
                          child: const Text(
                            "Harydyn ady (Rusca)",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400),
                          ),
                        ),

                        TextFormField(
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: Color.fromRGBO(239, 239, 239, 1))),
                            contentPadding: const EdgeInsets.all(12),
                          ),
                        ),

                        Container(
                          margin: const EdgeInsets.only(top: 15, bottom: 10),
                          child: const Text(
                            "Kategoriya",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 15, right: 20),
                          width: MediaQuery.of(context).size.width - 40,
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(238, 238, 238, 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DropdownButton(
                            underline: DropdownButtonHideUnderline(
                              child: Container(),
                            ),
                            isExpanded: true,
                            dropdownColor:
                                const Color.fromRGBO(238, 238, 238, 1),
                            iconEnabledColor:
                                const Color.fromRGBO(97, 97, 97, 1),
                            icon: const Icon(Icons.keyboard_arrow_down),
                            iconSize: 30,
                            elevation: 5,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(41, 41, 41, 1)),
                            items: const [
                              DropdownMenuItem(
                                child: Text(
                                  "Asgabat",
                                ),
                                value: 'a',
                              ),
                              DropdownMenuItem(
                                child: Text(
                                  "Lebap",
                                ),
                                value: 'l',
                              ),
                              DropdownMenuItem(
                                child: Text(
                                  "Mary",
                                ),
                                value: 'm',
                              ),
                              DropdownMenuItem(
                                child: Text(
                                  "Balkan",
                                ),
                                value: 'b',
                              ),
                              DropdownMenuItem(
                                child: Text(
                                  "Dasoguz",
                                ),
                                value: 'd',
                              ),
                              DropdownMenuItem(
                                child: Text(
                                  "Ahal",
                                ),
                                value: 'ah',
                              )
                            ],
                            onChanged: (val) {
                              setState(() {
                                selectedCategory = val.toString();
                              });
                            },
                            value: selectedCategory,
                          ),
                        ),

                        Container(
                          margin: const EdgeInsets.only(top: 15, bottom: 10),
                          child: const Text(
                            "Sub-Kategoriya",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 15, right: 20),
                          width: MediaQuery.of(context).size.width - 40,
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(238, 238, 238, 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DropdownButton(
                            underline: DropdownButtonHideUnderline(
                              child: Container(),
                            ),
                            isExpanded: true,
                            dropdownColor:
                                const Color.fromRGBO(238, 238, 238, 1),
                            iconEnabledColor:
                                const Color.fromRGBO(97, 97, 97, 1),
                            icon: const Icon(Icons.keyboard_arrow_down),
                            iconSize: 30,
                            elevation: 5,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(41, 41, 41, 1)),
                            items: const [
                              DropdownMenuItem(
                                child: Text(
                                  "Asgabat",
                                ),
                                value: 'a',
                              ),
                              DropdownMenuItem(
                                child: Text(
                                  "Lebap",
                                ),
                                value: 'l',
                              ),
                              DropdownMenuItem(
                                child: Text(
                                  "Mary",
                                ),
                                value: 'm',
                              ),
                              DropdownMenuItem(
                                child: Text(
                                  "Balkan",
                                ),
                                value: 'b',
                              ),
                              DropdownMenuItem(
                                child: Text(
                                  "Dasoguz",
                                ),
                                value: 'd',
                              ),
                              DropdownMenuItem(
                                child: Text(
                                  "Ahal",
                                ),
                                value: 'ah',
                              )
                            ],
                            onChanged: (val) {
                              setState(() {
                                selectedCategory = val.toString();
                              });
                            },
                            value: selectedCategory,
                          ),
                        ),

                        Container(
                          margin: const EdgeInsets.only(top: 15, bottom: 10),
                          child: const Text(
                            "Olcegleri",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.only(left: 15, right: 20),
                          width: MediaQuery.of(context).size.width - 40,
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(238, 238, 238, 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color.fromRGBO(
                                          189, 189, 189, 1),
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.white),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 30),
                                  child: Text(
                                    "S",
                                    style: TextStyle(
                                        color: Color.fromRGBO(189, 189, 189, 1),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14),
                                  ),
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    const Text("Gutardy",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14)),
                                    Switch.adaptive(
                                        activeTrackColor: const Color.fromRGBO(
                                            189, 189, 189, 1),
                                        value: change,
                                        onChanged: (value) {
                                          setState(() {
                                            change = value;
                                          });
                                        })
                                  ],
                                ),
                              ),
                              Container(
                                child: const Icon(
                                  Icons.delete_outline,
                                  color: Color.fromRGBO(189, 189, 189, 1),
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.only(left: 15, right: 20),
                          width: MediaQuery.of(context).size.width - 40,
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(238, 238, 238, 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color.fromRGBO(
                                          189, 189, 189, 1),
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.white),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 30),
                                  child: Text(
                                    "L",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14),
                                  ),
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    const Text("Gutardy",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14)),
                                    Switch.adaptive(
                                        activeTrackColor: const Color.fromRGBO(
                                            189, 189, 189, 1),
                                        value: change,
                                        onChanged: (value) {
                                          setState(() {
                                            change = value;
                                          });
                                        })
                                  ],
                                ),
                              ),
                              Container(
                                child: const Icon(
                                  Icons.delete_outline,
                                  color: Color.fromRGBO(189, 189, 189, 1),
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          width: MediaQuery.of(context).size.width / 2 - 20,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color.fromRGBO(255, 20, 29, 1),
                            ),
                            borderRadius: BorderRadius.circular(8),
                            //color: Colors.white
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 20),
                            child: Row(
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(right: 5),
                                  child: Icon(Icons.add),
                                ),
                                Text("Olceg gornusi",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14))
                              ],
                            ),
                          ),
                        ),

                        Container(
                          margin: const EdgeInsets.only(top: 15, bottom: 10),
                          child: const Text(
                            "Renkleri",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.only(left: 15, right: 20),
                          width: MediaQuery.of(context).size.width - 40,
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(238, 238, 238, 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 35,
                                width: 70,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.blue),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    const Text("Gutardy",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14)),
                                    Switch.adaptive(
                                        activeTrackColor: const Color.fromRGBO(
                                            189, 189, 189, 1),
                                        value: change,
                                        onChanged: (value) {
                                          setState(() {
                                            change = value;
                                          });
                                        })
                                  ],
                                ),
                              ),
                              Container(
                                child: const Icon(
                                  Icons.delete_outline,
                                  color: Color.fromRGBO(189, 189, 189, 1),
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 15, right: 20),
                          width: MediaQuery.of(context).size.width - 40,
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(238, 238, 238, 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 35,
                                width: 70,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.white),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    const Text("Gutardy",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14)),
                                    Switch.adaptive(
                                        activeTrackColor: const Color.fromRGBO(
                                            189, 189, 189, 1),
                                        value: change,
                                        onChanged: (value) {
                                          setState(() {
                                            change = value;
                                          });
                                        })
                                  ],
                                ),
                              ),
                              Container(
                                child: const Icon(
                                  Icons.delete_outline,
                                  color: Color.fromRGBO(189, 189, 189, 1),
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          width: MediaQuery.of(context).size.width / 2 - 20,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color.fromRGBO(255, 20, 29, 1),
                            ),
                            borderRadius: BorderRadius.circular(8),
                            //color: Colors.white
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 20),
                            child: Row(
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(right: 5),
                                  child: Icon(Icons.add),
                                ),
                                Text("Renk gosmak",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14))
                              ],
                            ),
                          ),
                        ),

                        Container(
                          margin: const EdgeInsets.only(top: 50, bottom: 20),
                          width: MediaQuery.of(context).size.width - 40,
                          height: 50,
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.red),
                                  elevation: MaterialStateProperty.all(5),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ))),
                              onPressed: () {
                                //Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyAddress()));
                              },
                              child: const Padding(
                                  padding: EdgeInsets.only(top: 15, bottom: 15),
                                  child: Text(
                                    "Dowam et",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  )),
                            ),
                          ),
                        ),
                      ],
                    )
                  ])),
                ],
              ),
            ),
          ],
        ));
  }
}
