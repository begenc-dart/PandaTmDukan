import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Chats_Person extends StatefulWidget {
  const Chats_Person({Key? key}) : super(key: key);

  @override
  _Chats_PersonState createState() => _Chats_PersonState();
}

class _Chats_PersonState extends State<Chats_Person> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
           Row(
             children: [
               InkWell(
                 onTap: (){
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
                     child: Icon(
                         Icons.arrow_back_ios
                     ),
                   ),
                 ),
               ),
               const Padding(
                 padding: EdgeInsets.only(left: 24, right: 20),
                 child: CircleAvatar(
                   backgroundImage: NetworkImage(
                       "https://imgresizer.eurosport.com/unsafe/1200x0/filters:format(jpeg):focal(1170x313:1172x311)/origin-imgresizer.eurosport.com/2022/07/04/3403700-69554168-2560-1440.jpg"),
                 ),
               ),
               const Text("Begench Jumayev",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
             ],
           ),
            SvgPicture.asset("asset/logo/Group 282.svg")
          ],
        ),
      ),

    );
  }
}
