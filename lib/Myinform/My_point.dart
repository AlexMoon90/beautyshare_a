import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:beautyshare_a/Myinform/My_payment.dart';

class my_point extends StatelessWidget {
  final int mypoint ;
  my_point(this.mypoint);

  var f = NumberFormat('###,###,###');

  @override
  Widget build(BuildContext context) {


    return

      Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.1,
          leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: ()=>Navigator.pop(context)),
          title: Text('적립내역 (최근 6개월)'),

        ),
        body:
        Padding(
          padding: const EdgeInsets.only(top:15.0),
          child: Container(
            height: 70.0,
            color:  Color.fromRGBO(227, 101, 180, 1.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text("총 적립포인트", style: TextStyle(color: Colors.white, fontSize: 18.0),),
                Container(
                    width: 100.0,
                    child: Text(" ${f.format(mypoint)} P" , style: TextStyle(color: Colors.white, fontSize: 18.0),textAlign: TextAlign.center ,)),

                GestureDetector(
                  onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => my_payment(mypoint)));},
                  child: Container(
                    width: 100.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50.0),),
                      child: Center(child: Text("결제하기", style: TextStyle(color: Color.fromRGBO(227, 101, 180, 1.0), fontSize: 15.0),textAlign: TextAlign.center, ))),
                )

              ],
            ),
          ),
        ),

      );





  }

}