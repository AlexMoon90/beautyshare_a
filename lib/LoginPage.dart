import 'package:flutter/material.dart';
import 'auth.dart';
import 'Mainpage.dart';
import 'fancyButton.dart';
import 'Google_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:beautyshare_a/Model/User_Provider.dart';
import 'User.dart';
import 'User_form.dart';
import 'SignUP.dart';

class LoginPage extends StatefulWidget {
  LoginPage(this.auth, );

  final AuthImpl auth;


  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {
  final formKey = new GlobalKey<FormState>();


  TextEditingController emailctr = TextEditingController();
  TextEditingController passctr = TextEditingController();



  @override
  Widget build(BuildContext context) {

    validateAndSubmit() async {
      if (formKey.currentState.validate()) {
       await widget.auth.signIn(emailctr.text, passctr.text).then((a) {user_transform (a.email, context);});
      }
    }


    Future<bool> google_user () async {
      await FBApi.signInWithGoogle().then((a) {user_transform( a.firebaseUser.email, context);});
    //  var b= guser.firebaseUser.uid;
   //   user_transform(b, context);
    }


    return MaterialApp(
      debugShowCheckedModeBanner: false ,
      home:  Scaffold(

          body: Center(
            child: Container(

                padding: EdgeInsets.all(16.0),
                child: new Form(
                  key: formKey,
                  child:  ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      _title(),
                      _emailInput(),
                      _passwordInput(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
                        child: Fancybutton2("로그인 하기", ()=>validateAndSubmit()),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
                        child: Row(

                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            GestureDetector(
                                child: Text("비밀번호찾기"),
                                onTap: null,
                            ),
                            GestureDetector(
                                child: Text("회원가입"),
                              onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context)=> sign_up(widget.auth) )) ; },
                            ),

                          ],
                        ),
                      ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
                    child: RawMaterialButton(onPressed:  google_user,
                      elevation: 2.0,
                      splashColor: Colors.deepOrange,
                      shape: StadiumBorder(side: BorderSide(color: Color.fromRGBO(227, 101, 180, 1.0),width: 3.0 )),
                      constraints: BoxConstraints.tightForFinite(width: 380.0, height: 45.0),
                      child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset("images/google_logo.png",width: 20.0, height: 20.0,),
                              Padding(
                                padding: const EdgeInsets.only(left : 10.0),
                                child: Text("구글로 로그인", style: TextStyle(color: Colors.black, fontSize: 16.0), ),
                              ),
                            ],
                          )),
                    ),
                  ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
                        child: RawMaterialButton(onPressed:  null ,
                          elevation: 2.0,
                          splashColor: Colors.deepOrange,
                          shape: StadiumBorder(side: BorderSide(color: Color.fromRGBO(227, 101, 180, 1.0),width: 3.0 )),
                          constraints: BoxConstraints.tightForFinite(width: 380.0, height: 45.0),
                          child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset("images/facebook_logo.png",width: 20.0, height: 20.0,),
                                  Padding(
                                    padding: const EdgeInsets.only(left : 10.0),
                                    child: Text("페이스북으로 로그인", style: TextStyle(color: Colors.black, fontSize: 16.0), ),
                                  ),
                                ],
                              )),
                        ),
                      ),

                    ],
                  ),
                )),
          )),
    );
  }


  Widget _title() {
    return Center(child: Text("BUEATY SHARE", style: TextStyle(color: Color.fromRGBO(227, 101, 180, 1.0), fontSize: 25.0), ));
  }

  Widget _sizedBox(_height) {
    return new SizedBox(height: _height);
  }

  Widget _emailInput() {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 70.0, vertical: 2.0),
      child: TextFormField(
        textAlign: TextAlign.center,
        controller: emailctr,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(227, 101, 180, 1.0))),
            hintStyle: TextStyle(color: Colors.grey, fontSize: 13.0, ),
            hintText: '이메일을 입력해주세요',
            icon: Icon(Icons.email, color: Color.fromRGBO(227, 101, 180, 1.0),)
                 ),
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
      ),
    );
  }

  Widget _passwordInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 70.0, vertical: 2.0),
      child: TextFormField(
        textAlign: TextAlign.center,
        controller: passctr,
        obscureText: true,
        autofocus: false,
         decoration:    InputDecoration(
           focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(227, 101, 180, 1.0))),
            hintStyle: TextStyle(color: Colors.grey, fontSize: 13.0),
            hintText: '패스워드를 입력해주세요',
            icon: Icon(Icons.lock, color: Color.fromRGBO(227, 101, 180, 1.0),)

         ),
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
      ),
    );
  }

}