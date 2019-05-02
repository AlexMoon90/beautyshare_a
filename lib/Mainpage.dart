import 'package:flutter/material.dart';
import 'package:beautyshare_a/Usage/Usagepage.dart';

import 'Mainpage_usege.dart';
import 'Mainpage_shop.dart';
import 'package:flutter/cupertino.dart';
import 'package:beautyshare_a/Location/Locationpage.dart';
import 'package:beautyshare_a/Promotion/Promotionpage.dart';
import 'package:beautyshare_a/Myinform/My_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';



class Mainpage extends StatelessWidget {


  @override

  Widget build(BuildContext context) {

  return
      MaterialApp(

        theme: ThemeData(primaryColor: Colors.white,
          backgroundColor: Colors.white
      ),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          drawer: mydrawer(context),

          appBar: AppBar(
            primary: true,

            elevation: 0.0,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color:   Color.fromRGBO(234, 98, 209, 1.0)),

            centerTitle: true,
            title: Text(
              " BEAUTY SHARE",
              style: TextStyle(color: Colors.black),
            ),
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.search,
                      size: 30.0, color:  Color.fromRGBO(234, 98, 209, 1.0)),
                  onPressed: null)
            ],
          ),
          body: ListView(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                  child: Image.asset(
                    'images/main_image.png',
                    height: 150.0,
                    width: 450.0,
                    fit: BoxFit.fill,
                  ),
                ),
              Container(
                height: 150.0,
                width: 450.0,
                child: Center(child: Text('''단골샵 예약 및 이용하고 포인트받고
          후기올리고 포인트 또받고''', style: TextStyle(fontSize: 20.0,  color: Colors.white),)),
              ),
              ]
              ),

             Stack(
              children: <Widget>[
                Container(
                child: Image.asset('images/eyelasj.png',
                    height: 80.0, width: 450.0, fit: BoxFit.fill),
              ),
                Container(
                  height: 80.0,
                  width: 450.0,
                  child: Row(
                    children: <Widget>[
                      Expanded(

                        child: Padding(
                          padding: const EdgeInsets.only(left : 15.0),
                          child: Text('눈썹디자인 시뮬레이션', style: TextStyle(color: Colors.white, fontSize: 18.0, decorationStyle: TextDecorationStyle.dashed, ), ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right : 10.0),
                        child: IconButton(
                            onPressed: (){},
                            icon: Icon(Icons.chevron_right, size: 50.0,color: Colors.white,)),
                      )
                    ],
                  ),
                ),

             ]
             ),

              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Container(
                    height: 70.0,

                    child: Row(

                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Usagepage()));

                            },
                            splashColor: Colors.pinkAccent[100],
                            borderRadius: BorderRadius.circular(50.0),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                '이용후기',
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {Navigator.of(context).push(CupertinoPageRoute(builder: (context) => Locationpage()));},
                            splashColor: Colors.pinkAccent[100],
                            borderRadius: BorderRadius.circular(50.0),

                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                '내주변샵',
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: (){Navigator.push(context, CupertinoPageRoute(builder: (context) => Promotionpage()));},
                            splashColor: Colors.pinkAccent[100],
                            borderRadius: BorderRadius.circular(50.0),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                '프로모션',
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ),
                          ),
                        ])),
              ),
              AppBar(
                automaticallyImplyLeading: false,
                title: Padding(
                  padding: const EdgeInsets.only (left : 10.0),
                  child: Text(
                    '이용후기',
                  ),
                ),
                elevation: 2.0,
                actions: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: IconButton(
                      onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => Usagepage()));},
                        icon: Icon(
                      Icons.chevron_right,
                      size: 40.0,
                          color: Colors.grey,
                    )),
                  ),
                ],
              ),
              Container(
                height: 180.0,
                child: Main_usage() ),
              AppBar( automaticallyImplyLeading: false,
                elevation: 2.0,
                title: Padding(
                  padding: const EdgeInsets.only(left : 10.0),
                  child: Text(
                    '내주변샵',
                  ),
                ),
                actions: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: IconButton(
                        onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => Locationpage()));},
                        icon: Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                      size: 40.0,
                    )),
                  ),
                ],
              ),
              Container(
                height: 180.0,
                child: Main_shop()
              )
            ],
          )),
      );
  }
}
