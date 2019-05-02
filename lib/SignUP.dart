import 'package:flutter/material.dart';
import 'auth.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'fancyButton.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';





class sign_up extends StatefulWidget {
  final Auth auth;
  sign_up(this.auth);

  @override
  _sign_upState createState() => _sign_upState();
}

class _sign_upState extends State<sign_up> {

  final formKey = new GlobalKey<FormState>();
  var emailctr = TextEditingController();
  var passctr1 = TextEditingController();
  var passctr2 = TextEditingController();
  var dipnamectr = TextEditingController();

  File selectImage;


  String imagename1;


  Future getImage() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery, maxWidth: 300.0, maxHeight: 300.0);

    setState(() {
      selectImage = tempImage;
    });
  }

  cancelcall() {
    setState(() {
      selectImage = null;
    });
  }

  signup_process (String email, String pass) {
    widget.auth.signUp(email, pass).then((a) async {firestore_upload(a);}) ;

    Navigator.pop(context);

  }

  Future firestore_upload( FirebaseUser user) async {

    String userid_re = emailctr.text;
    imagename1 = '${userid_re}' + '/${DateTime.now()}' + '.jpg';
    var reference = Firestore.instance.collection('User').document(user.email);

    await (  postToFireStore(
      displayName: dipnamectr.text,
      email: emailctr.text).whenComplete(()=>uploadImage(selectImage).then((url){ reference.updateData({"photoUrl" : url});  })));

  /*  await (uploadImage(selectImage).then((
         url) {
      postToFireStore(
          uid: uid,
          displayName: dipnamectr.text,
          email: emailctr.text,
          photoUrl: url,  );
    })); */

  }


  // 사진 3개를 Firestor에 저장하고 URL 다운로드 주소를 받아오는 기능

  Future<String> uploadImage(var imageFile) async {

    String url1;

    FirebaseStorage storage = FirebaseStorage.instance;

    if(imageFile != null) {
      StorageReference ref1 = storage.ref().child(imagename1);
      StorageUploadTask uploadTask1 = ref1.putFile(imageFile);
      var dowurl1 = await ( await uploadTask1.onComplete).ref.getDownloadURL();
      url1 = dowurl1.toString();
    }

    return url1;
  }

// 파이어스토어 리뷰정보를 저장하는 기능
  Future postToFireStore(
      {String email, String displayName, String photoUrl}) async {

    var reference = Firestore.instance.collection('User').document(email);
    reference.setData( {
      "displayName" : displayName,
      "email": email,
      "photoUrl": photoUrl,
      "photopath" : imagename1

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          elevation: 2.0,
          backgroundColor: Colors.white,
          title: Padding(
            padding: const EdgeInsets.only(top : 13.0),
            child: Text( '회원가입',

              style: TextStyle(color: Colors.black),
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top : 15.0),
              child: IconButton(
                  icon: Icon(
                    Icons.close,
                    color:  Color.fromRGBO(227, 101, 180, 1.0),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            )
          ],
        ),
      ),

      body: Form(
           key: formKey,
            child: Padding(
              padding: const EdgeInsets.only(top : 50.0),
              child: ListView(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[
                  Padding(
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
        ),),

      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 70.0, vertical: 2.0),
        child: TextFormField(
          textAlign: TextAlign.center,
          controller: passctr1,
          obscureText: true,
          autofocus: false,
          decoration:    InputDecoration(
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(227, 101, 180, 1.0))),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 13.0),
                    hintText: '패스워드를 입력해주세요',
                    icon: Icon(Icons.lock, color: Color.fromRGBO(227, 101, 180, 1.0),)

          ),
          validator: (value) => value.isEmpty ? '이메일이 없습니다' : null,
        ),
      ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 70.0, vertical: 2.0),
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      controller: passctr2,
                      obscureText: true,
                      autofocus: false,
                      decoration:    InputDecoration(
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(227, 101, 180, 1.0))),
                          hintStyle: TextStyle(color: Colors.grey, fontSize: 13.0),
                          hintText: '패스워드를 한번더 입력해주세요',
                          icon: Icon(Icons.lock, color: Color.fromRGBO(227, 101, 180, 1.0),)

                      ),
                      validator: (value)  { if (value.isEmpty) {
                                              return ' 패스워드가 없습니다' ; }
                                              else if (value !=passctr1.text) {
                                                return '패스워드가 2개 모두 일치해야 합니다' ;   }
                                              },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only (top: 30.0, bottom: 10.0),
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                      child: GestureDetector(
                        onTap: getImage,
                        onLongPress: cancelcall,
                        child: Container(
                          alignment: Alignment(0.0, 0.0),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(50.0)),
                          padding: EdgeInsets.all(0.0),
                          height: 100.0,
                          width: 100.0,
                          child: selectImage == null
                              ? Stack ( alignment : Alignment(0.0, 0.0),children : [
                                Icon(Icons.add,size: 35.0,),
                                Text('''프로필 사진을
                                
                                    선택해주세요''', style: TextStyle(color: Colors.black38, fontSize: 12.0), textAlign: TextAlign.center, )
                          ] )
                              : Image.file(selectImage, height: 200.0, width: 150.0),
                        ),
                      ),
                    ),
                  ),

      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 70.0, vertical: 2.0),
        child: TextFormField(
          textAlign: TextAlign.center,
          controller: dipnamectr,
          keyboardType: TextInputType.emailAddress,
          autofocus: false,
          decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(227, 101, 180, 1.0))),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 13.0, ),
                    hintText: '프로필명을 입력해주세요',
                    icon: Icon(Icons.person, color: Color.fromRGBO(227, 101, 180, 1.0),)
          ),
          validator: (value) => value.isEmpty ? '프로필명이 없습니다' : null,
        ),
      ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
                    child: RawMaterialButton(onPressed: () {
                      if(formKey.currentState.validate() && selectImage !=null ) {

                        signup_process(emailctr.text, passctr2.text);
                      }

                      else { Scaffold.of(context).showSnackBar(SnackBar(content: Text(' 누락된 정보를 확인후 입력해주세요 '))); }


                    },
                      fillColor:   Color.fromRGBO(234, 98, 209, 1.0),
                      splashColor: Colors.deepOrange,
                      shape: StadiumBorder(),

                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            width: 370.0,
                            height: 30.0,
                            child: Center(child: Text( '회원가입하기', style: TextStyle(color: Colors.white, fontSize: 16.0), ))),
                      ),
                    ),
                  ),

        ],

                  ),
                ],
              ),
            )

      ),

    );



  }
}
