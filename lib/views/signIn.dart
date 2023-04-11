import 'package:dukanlar/server/LogIn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _logInKey = GlobalKey<FormState>();
  bool otomatikKontrol = false;
   String _logIn="", _password="";
    bool _passwordVisible = false;

   @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(30),
          child: Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "asset/images/logo.png",
                      height: 90,
                      width: 90,
                    ),
                    Text(
                      "Dukanym",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 30,
                          color: Color.fromRGBO(97, 97, 97, 1)),
                    )
                  ],
                ),
              ),

              //2
              Container(
                margin: EdgeInsets.only(top: 70, bottom: 45),
                child: Center(
                  child: Text("Dukanyn id sini we paroly yazmaly:",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 32,
                          color: Color.fromRGBO(39, 39, 39, 1))),
                ),
              ),
              Form(
                key: _logInKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 15, bottom: 10),
                      child: Text(
                        "Telefon belginizi giriziň",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Color.fromRGBO(39, 39, 39, 1)),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          prefixText: "+993",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(239, 239, 239, 1))),
                          contentPadding: EdgeInsets.all(12),
                        ),
                        onSaved: (result) => _logIn = result!,
                      ),
                    ),
                    //parol
                    Container(
                      margin: EdgeInsets.only(top: 15, bottom: 10),
                      child: Text(
                        "Acar sozuniz",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Color.fromRGBO(39, 39, 39, 1)),
                      ),
                    ),

                    TextFormField(
                      keyboardType: TextInputType.name,
                      obscureText: !_passwordVisible,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                          // Based on passwordVisible state choose the icon
                          _passwordVisible
                          ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.red,
                          ),
                          onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                          _passwordVisible = !_passwordVisible;
                          });},),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Color.fromRGBO(239, 239, 239, 1))),
                        contentPadding: EdgeInsets.all(12),
                      ),
                      onSaved: (result) => _password = result!,
                    ),
                  ],
                ),
              ),
              //txt
              Container(
                margin: EdgeInsets.only(
                  top: 40,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.account_box_outlined,
                      color: Color.fromRGBO(97, 97, 97, 1),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        "Id we acar soz ucin serpay admine yuz tutmaly",
                        style: TextStyle(
                            color: Color.fromRGBO(97, 97, 97, 1),
                            fontSize: 13,
                            fontWeight: FontWeight.w300),
                      ),
                    )
                  ],
                ),
              ),

              //button
              Container(
                margin: EdgeInsets.only(top: 60, bottom: 20),
                width: MediaQuery.of(context).size.width - 40,
                height: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                        elevation: MaterialStateProperty.all(5),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ))),
                    onPressed: () async{

                     logInOpen(context);
                      //Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyAddress()));
                    },
                    child: Padding(
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
          ),
        ),
      ),
    );
  }

  void logInOpen(BuildContext context) async {
    if (_logInKey.currentState!.validate()) {
      _logInKey.currentState!.save();

      await PostLogIn().createUser("+993$_logIn", _password, context);
      setState(() {});
    } else {
      setState(() {
        otomatikKontrol = true;
      });
    }
  }
}
