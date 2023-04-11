import 'package:dukanlar/Database/Check.dart';
import 'package:dukanlar/Database/Language/GetLanguage.dart';
import 'package:dukanlar/Model/LanguageModel.dart';
import 'package:dukanlar/Model/getOneProduct.dart';
import 'package:dukanlar/server/CategoryaModel.dart';
import 'package:dukanlar/server/Get_Me.dart';

import 'package:dukanlar/views/Categorya/Categoriya.dart';
import 'package:dukanlar/views/Chats/Chats.dart';
import 'package:dukanlar/views/ExcelFile/Excel_file_gos.dart';
import 'package:dukanlar/views/Profile/Profile.dart';
import 'package:dukanlar/views/Zakazlar/Zakazlar.dart';

import 'package:dukanlar/views/chat.dart';
import 'package:dukanlar/views/dukan.dart';
import 'package:dukanlar/views/editProduct.dart';

import 'package:dukanlar/views/signIn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'CategorChangeNoti.dart';
import 'Database/Language/LanguagePath.dart';
import 'Database/count.dart';
import 'Model/CategoriyaQT.dart';
import 'Model/ProductsModel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  List<CategoriyaModel> cate = [];
  await caregoriyaAlbum().then((value) {
    cate = value;
  });
  late ProductsMainPageModel productNoti;
  String url = "";
  await LanguageFileRead().then((value) {
    url = value;
  });
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<MainPageProv>(
          create: (context) => MainPageProv(0),
        ),
        ChangeNotifierProvider<ChangeNot>(
          create: (context) => ChangeNot(cate),
        ),

        ChangeNotifierProvider<ChangeNot>(
          create: (context) => ChangeNot(cate),
        ),
        ChangeNotifierProvider<LanguageNot>(
          create: (context) => LanguageNot(url),
        )
      ],
      child: MatPage()));
}
class MatPage extends StatefulWidget {
  const MatPage({Key? key}) : super(key: key);

  @override
  State<MatPage> createState() => _MatPageState();
}

class _MatPageState extends State<MatPage> {
  @override
  String a = "";

  nethod()async{
    await CheckSignUp().dosyaOku().then((value) {
      debugPrint(value.toString());
      a = value;
      debugPrint(a.toString() + "dsfds");
    });

  }
  @override
  void initState() {
    nethod();
    // TODO: implement initState
    super.initState();
  }
  Widget build(BuildContext context) {
    nethod();
    print(a+"sadsa");
    return MaterialApp(
      title: 'Dukan',
      theme: ThemeData(
          primaryColor: Colors.red,
          buttonTheme: ButtonThemeData(
            height: 50,
            buttonColor: Color.fromRGBO(255, 20, 29, 1),
          ),
          backgroundColor: Colors.white,
          inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    width: 1, color: Color.fromRGBO(174, 174, 174, 1)),
                borderRadius: BorderRadius.circular(5),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 1, color: Colors.blue),
                borderRadius: BorderRadius.circular(5),
              ),
              filled: false,
              fillColor: Color.fromRGBO(97, 97, 97, 1)),
          appBarTheme: const AppBarTheme(
            color: Color.fromRGBO(250, 250, 250, 1),
            elevation: 0.5,
            titleTextStyle: TextStyle(
              color: Color.fromRGBO(39, 39, 39, 1),
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            iconTheme: IconThemeData(
              color: Color.fromRGBO(39, 39, 39, 1),
              size: 20,
            ),
            actionsIconTheme:
            IconThemeData(color: Color.fromRGBO(39, 39, 39, 1), size: 24),
          )),
      debugShowCheckedModeBanner: false,
      home:Materi(a: a,)

    );
  }
}
class Materi extends StatefulWidget {
  String a;
   Materi({Key? key,required this.a}) : super(key: key);

  @override
  State<Materi> createState() => _MateriState();
}

class _MateriState extends State<Materi> {
  String a="";
  nethod()async{
    await CheckSignUp().dosyaOku().then((value) {
      debugPrint(value.toString());
      a = value;
      debugPrint(widget.a.toString() + "dsfds");
      setState(() {

      });
    });

  }

  @override
  void initState() {
    nethod();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  a.toString().length == 4 ? MyHomePage():SignIn();
  }
}

class MyHomePage extends StatefulWidget {


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Dukan dukan = Dukan();
Excel_File excel_file=Excel_File();
  Chat chat = const Chat();
  Profile profile = Profile();

  EditProduct editProduct = EditProduct();
  SignIn signIn = const SignIn();
  Categoriya categoriya = const Categoriya();

  Zakazlar _zakazlar = Zakazlar();
  List hemmeSah = [];
  int saylanan = 0;
String zakaz="";

  initState() {

    hemmeSah = [dukan, categoriya,excel_file, _zakazlar, profile];

  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Language().fetchAlbum(context),
      builder: (BuildContext context, AsyncSnapshot<LanguageModel> snapshot) {
     debugPrint(snapshot.toString());
        if (snapshot.hasData) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            body: SafeArea(
              child: hemmeSah[saylanan],
            ),
            bottomNavigationBar: BottomNavigationBar(
              showSelectedLabels: true,
              showUnselectedLabels: true,
              items: [

                BottomNavigationBarItem(
                    activeIcon: Column(
                      children: [
                        Container(
                          height: 3,
                          width: 25,
                          color: const Color.fromRGBO(255, 20, 29, 1),
                        ),
                        const Icon(Icons.home)
                      ],
                    ),
                    icon: const Icon(Icons.home),
                    label:"PandaTm"),
                BottomNavigationBarItem(
                    activeIcon: Column(
                      children: [
                        Container(
                          height: 3,
                          width: 25,
                          color: const Color.fromRGBO(255, 20, 29, 1),
                        ),
                        const Icon(Icons.category)
                      ],
                    ),
                    icon: const Icon(Icons.category),
                    label: snapshot.data!.kat),
                BottomNavigationBarItem(
                    activeIcon: Column(
                      children: [
                        Container(
                          height: 3,
                          width: 25,
                          color: const Color.fromRGBO(255, 20, 29, 1),
                        ),
                        const Icon(Icons.add)
                      ],
                    ),
                    icon: const Icon(Icons.add),
                    label: "Excel"),
                BottomNavigationBarItem(
                    activeIcon: Column(
                      children: [
                        Container(
                          height: 3,
                          width: 25,
                          color: const Color.fromRGBO(255, 20, 29, 1),
                        ),
                        const Icon(Icons.open_in_browser_rounded)
                      ],
                    ),
                    icon: const Icon(Icons.open_in_browser_rounded),
                    label: snapshot.data!.sargyt),
                // BottomNavigationBarItem(
                //     activeIcon: Column(
                //       children: [
                //         Container(
                //           height: 3,
                //           width: 25,
                //           color: const Color.fromRGBO(255, 20, 29, 1),
                //         ),
                //         const Icon(Icons.chat_bubble_outline)
                //       ],
                //     ),
                //     icon: const Icon(Icons.chat_bubble_outline),
                //     label: "Kategoriya"),
                BottomNavigationBarItem(
                    activeIcon: Column(
                      children: [
                        Container(
                          height: 3,
                          width: 25,
                          color: const Color.fromRGBO(255, 20, 29, 1),
                        ),
                        const Icon(Icons.person)
                      ],
                    ),
                    icon: const Icon(Icons.person),
                    label: snapshot.data!.profile),
              ],
              fixedColor: const Color.fromRGBO(55, 58, 64, 1),
              type: BottomNavigationBarType.fixed,
              currentIndex: saylanan,
              onTap: ((index) {
                saylanan = index;
                setState(() {});
              }),
            ),
          );
        }
        else{
          return Scaffold(body: Center(child: CircularProgressIndicator(color: Colors.red,)));
        }
      },
    );
  }
}
