
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:beautyshare_a/Model/model_shopinfo.dart';
import 'package:beautyshare_a/Model/model_stylist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_calendar/flutter_calendar.dart';
import 'package:beautyshare_a/fancyButton.dart';

class reservation extends StatefulWidget {
  final Record_loca shopinfo;
  reservation(this.shopinfo);
  @override
  _reservation createState() => new _reservation();
}

//State is information of the application that can change over time or when some actions are taken.
class _reservation extends State<reservation>{


  int shopvalue = 0;
  int stylistvalue=0;
  List <bool> productvalue =[];
  DateTime selectday;

  String shopclass;
  String productclass;
  Record_stylist stylistclass;

  int selectedtime;


@override
  void initState() {
    // TODO: implement initState

  shopclass= widget.shopinfo.shop_class[0];
  productclass = widget.shopinfo.product_class[shopclass][0];
  List produclist= widget.shopinfo.product_class[shopclass];

  for (int i=0;i<produclist.length;i++) {

    productvalue.add(false);
    print(productvalue[i]);
  }


    super.initState();
  }




  List<Widget> makeshopclass() {
    List<Widget> list = new List<Widget>();
         for (int i = 0; i <widget.shopinfo.shop_class.length; i++) {
           list.add(

               Row(
                 children: <Widget>[
                   Text(widget.shopinfo.shop_class[i]),
                   Radio(
                     value: i,
                     groupValue: shopvalue,
                     onChanged: (value){
                       setState(() {
                         shopvalue=value;
                         shopclass = widget.shopinfo.shop_class[value];

                       });
                     },
                     activeColor: Color.fromRGBO(227, 101, 180, 1.0),
                   ),
                 ],
               ));
         }

    return list;
  }




  List<Widget> makeproductclass() {
    List<Widget> list = [];
    List produclist= widget.shopinfo.product_class[shopclass];
    if(produclist!=null) {
    for (int i = 0; i <produclist.length; i++) {
      list.add(

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
                Text(produclist[i]),
                Checkbox(
                  activeColor:  Color.fromRGBO(227, 101, 180, 1.0),
                  value: productvalue[i],
                  onChanged: (value) { setState(() {
                    productvalue[i] = value;

                  });},
                ),
              ],
            ),
          ));
    }}

    return list;
  }

Widget makestylistclass() {

 var stylistshot= widget.shopinfo.reference.collection("stylist").snapshots();
 List <Widget> stylistlist=[];
 return
 StreamBuilder(
     stream: stylistshot,
     builder: (BuildContext context, snapshot ) {
       stylistlist.clear();

       if(snapshot.hasData) {
       for (int i = 0; i < snapshot.data.documents.length; i++) {

         var stylistinfo = Record_stylist.fromsnapshot(snapshot.data.documents[i]);

         stylistlist.add(
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 50.0),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: <Widget>[
                   Text(stylistinfo.name+" "+stylistinfo.position),
                   Radio(
                     value: i,
                     groupValue: stylistvalue,
                     onChanged: (value){
                       setState(() {
                         stylistvalue=value;
                         stylistclass = stylistinfo;

                       });
                     },
                     activeColor: Color.fromRGBO(227, 101, 180, 1.0),
                   ),
                 ],
               ),
             ));
       }
       print(stylistlist.length);

 }
     return  Column(children: stylistlist);;
     }
 );

}



  Widget calendar_choise () {
 return Center(
   child: Container(
     width: 350.0,
     child: Calendar(
       showChevronsToChangeRange: false,
       showTodayAction: false,
        onSelectedRangeChange: (range) =>
            print("Range is ${range.item1}, ${range.item2}"),
        isExpandable: true,
        dayBuilder: (BuildContext context, DateTime day) {
          return  InkWell(
            onTap: () { setState(() {
              selectday=day;
              print(day.toString());
              print(selectday.toString());
            });},
            child:  Container(
              decoration: BoxDecoration(
                  color: (day==selectday)? Color.fromRGBO(227, 101, 180, 1.0) : null,
                  borderRadius: BorderRadius.all(Radius.circular(75.0))
              ),
              child: Center(
                child: new Text(
                  day.day.toString(),
                ),
              ),
            ),
          );
        },
      ),
   ),
 );

}

  Widget selectime() {

    int starttime = 9;
    int endtime = 21;
    List<int> notavailbletime=[13, 16, 19];
    List<Widget> timewidget=[];
    List<Widget> Nottimelist=[];

    String changetimevalue (int a){
      if(a<10) { return "0"+a.toString()+":00";}
      else return a.toString()+":00";
    }

    Widget Nottime= Container(
      margin: const EdgeInsets.only(left : 5.0, top : 15.0),
      padding: const EdgeInsets.all(8.0),

      decoration: BoxDecoration(

        backgroundBlendMode: BlendMode.colorBurn,
        color: Colors.black26.withOpacity(0.2),
        border: Border.all(width: 3.0,
        ),
        borderRadius: BorderRadius.all(Radius.circular(75.0),

        ),

      ),
      child: new Text(
        "  ${changetimevalue(9)}  ", style: TextStyle(fontSize: 13.0,
        color: Colors.black54.withOpacity(0.2),), ),
    );


    for(int i=starttime;i<endtime;i++) {
     timewidget.add( GestureDetector(
        onTap: () {
          setState(() {
            selectedtime = i;
          });
        },
        child: Container(
          margin: const EdgeInsets.only(left : 5.0, top : 15.0),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(

            border: Border.all(width: 3.0,
              color: (i == selectedtime)
                  ? Color.fromRGBO(227, 101, 180, 1.0)
                  : Colors.black54,),
            borderRadius: BorderRadius.all(Radius.circular(75.0),),

          ),
          child: new Text(
            "  ${changetimevalue(i)}  ", style: TextStyle(fontSize: 13.0,
            color:(i == selectedtime)
                ? Color.fromRGBO(227, 101, 180, 1.0)
                : Colors.black54,), ),
        ),
      ));
    }

    Nottimelist.add(Nottime);
    timewidget.replaceRange(0, 1, Nottimelist.getRange(0, 1));

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Center(
            child: Container(width : 350.0 ,child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, mainAxisSize: MainAxisSize.min,
                children : timewidget.getRange(0, 4).toList())),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Center(
            child: Container(width: 350.0 ,child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, mainAxisSize: MainAxisSize.min,
                children : timewidget.getRange(4, 8).toList())),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Center(
            child: Container(width: 350.0 ,child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, mainAxisSize: MainAxisSize.min,
                children : timewidget.getRange(8, (endtime-starttime)).toList())),
          ),
        ),

      ],
    );




  }


  @override
  Widget build(BuildContext context) {

print (shopclass);
    return new Scaffold(
      appBar:  AppBar(
      elevation: 0.2,
      backgroundColor: Colors.white,
      leading: IconButton(icon: Icon(Icons.arrow_back_ios, color: Colors.black87,), onPressed: ()=> Navigator.pop(context)),
      title:  Text("예약하기", style: TextStyle(color: Colors.black87),),
    ),
      //hit Ctrl+space in intellij to know what are the options you can use in flutter widgets
      body: ListView(
        children: <Widget>[
          Column (
            crossAxisAlignment: CrossAxisAlignment.start,
               children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left : 25.0, top: 25.0),
                child: Text("서비스 선택", textAlign: TextAlign.left, style: TextStyle(fontSize: 18.0),),
              ),
              Divider(),

              Row(                 children:
                  makeshopclass(),
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              ),

              Column(
                mainAxisSize: MainAxisSize.min,

                children: makeproductclass(),
              ),

              Padding(
                padding: const EdgeInsets.only(left : 25.0, top: 25.0),
                child: Text("담당 선택", textAlign: TextAlign.left, style: TextStyle(fontSize: 18.0),),
              ),
              Divider(),
              makestylistclass(),

              Padding(
                padding: const EdgeInsets.only(left : 25.0, top: 25.0),
                child: Text("날자 및 시간 선택", textAlign: TextAlign.left, style: TextStyle(fontSize: 18.0),),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.only(left : 50.0, top: 5.0),
                child: Text("날자 선택", textAlign: TextAlign.left, style: TextStyle(fontSize: 15.0),),
              ),
              calendar_choise(),
              Padding(
                padding: const EdgeInsets.only(left : 50.0, top: 5.0),
                child: Text("시간 선택", textAlign: TextAlign.left, style: TextStyle(fontSize: 15.0),),
              ),
                 selectime(),

              Padding(
                padding: const EdgeInsets.symmetric(vertical : 20.0),
                child: Container(
                  child: Center(
                    child: Fancybutton2("예약등록",() {

                    },),
                  ),
                ),
              )
            ],

          ),
        ],
      )


    );
  }
}
