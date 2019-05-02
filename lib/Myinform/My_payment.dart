import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:beautyshare_a/fancyButton.dart';

class my_payment extends StatelessWidget {
  final int mypoint;

  my_payment(this.mypoint);

  var f = NumberFormat('###,###,###');

  @override
  Widget build(BuildContext context) {
    return

      Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.1,
          leading: IconButton(icon: Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.pop(context)),
          title: Text('포인트 결제하기'),

        ),
        body:
        ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Container(
                    height: 70.0,
                    color: Color.fromRGBO(227, 101, 180, 1.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text("사용가능 포인트",
                          style: TextStyle(color: Colors.white, fontSize: 18.0),),
                        Container(
                            width: 100.0,
                            child: Text(" ${f.format(mypoint)} P",
                              style: TextStyle(color: Colors.white, fontSize: 18.0),
                              textAlign: TextAlign.center,)),

                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0 , vertical: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[

                    Text("결제할 포인트", style: TextStyle(fontSize: 18.0),),
                    Container(
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 120.0,
                                child: TextField()),
                            Text("P", style: TextStyle(color: Color.fromRGBO(227, 101, 180, 1.0), fontSize: 18.0),),
                          ],
                        )),

                  ],),
                ),

                Fancybutton2("결제하기",(){}),

             ],
            ),
          ],
        ),


      );
  }
}
