
import 'package:dukanlar/views/Chats/Chat_Person.dart';
import 'package:flutter/material.dart';

class Chats extends StatefulWidget {
  const Chats({Key? key}) : super(key: key);

  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      body: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Chats_Person()));
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 90,
                color: const Color.fromRGBO(250, 250, 250, 1),
                margin: const EdgeInsets.only(bottom: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 24, right: 20),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://imgresizer.eurosport.com/unsafe/1200x0/filters:format(jpeg):focal(1170x313:1172x311)/origin-imgresizer.eurosport.com/2022/07/04/3403700-69554168-2560-1440.jpg"),
                      ),
                    ),
                    const Text(
                      "Begench Jumayev",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 23),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: const Color.fromRGBO(130, 226, 151, 1)),
                            child: const Center(
                                child: Text(
                              "3",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w600),
                            )),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 15),
                            child: Text(
                              "21.09.2022   14:40",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 10),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
