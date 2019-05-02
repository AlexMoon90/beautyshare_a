import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'dart:async';
import 'package:beautyshare_a/Usage/Usage_review.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';
import 'Location_list.dart';
import 'Shop_inform.dart';
import 'package:beautyshare_a/fancyButton.dart';
import 'Shop_service.dart';
import 'Shop_service2.dart';
import 'Shop_review.dart';
import 'package:beautyshare_a/Model/model_shopinfo.dart';
import 'Reservation.dart';
import 'package:beautyshare_a/User.dart';



class locationinfor extends StatefulWidget {


  final Record_loca shopreco;
  final User cuser;
  final int paga_num ;
  locationinfor( this.shopreco, this.cuser, this.paga_num) ;
  _locationinforstate createState() => _locationinforstate();
}


class _locationinforstate extends State <locationinfor> {

  Color colormenu1 ;
  Color colormenu2 ;
  Color colormenu3 ;
  DocumentReference revewid ;
  bool favorcolor;
  int favornumm;

  Widget shop_contents;
  @override
  void initState() {
    // TODO: implement initState

    colormenu1 =  Colors.black;
    colormenu2 = Colors.black;
    colormenu3  = Colors.black;
    if(widget.paga_num ==1) {
        shop_contents = Shop_inform(widget.shopreco);
        colormenu1 =  Color.fromRGBO(234, 98, 209, 1.0);
    }
        else if(widget.paga_num==3) {
        shop_contents = shopreview(widget.shopreco);
        colormenu3 =  Color.fromRGBO(234, 98, 209, 1.0);
    }
    revewid = widget.cuser.reference;

    favornumm = (widget.shopreco.favorid == null) ? 0 : widget.shopreco.favorid.length ;


    if( widget.shopreco.favorid == null ) { favorcolor = false; }
    else if (widget.shopreco.favorid.contains(revewid)) {
      favorcolor=true; }
      else if (widget.shopreco.favorid.contains(revewid)==false)
        {favorcolor=false ;}


    super.initState();
  }


  @override

  Widget build(BuildContext context2) {
    // TODO: implement build


    return
      MaterialApp(
          debugShowCheckedModeBanner: false,

          home :  Scaffold(


              floatingActionButton: Fancybutton2("예약하기",() {
                Navigator.push(context, MaterialPageRoute(
                    builder: (cotext1) => reservation(widget.shopreco)));
              },),
              floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
              body:


              Stack(
                alignment: Alignment(-1.0, -1.0),
                children: <Widget>[


                  LayoutBuilder(builder: (BuildContext context, BoxConstraints viewportConstraints) {

                    return

                      SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(),
                          child: IntrinsicHeight(
                            child: Padding(
                              padding: const EdgeInsets.only (bottom : 100.0),
                              child: Column (
                                children  : [
                                  SafeArea(
                                    child: Stack(
                                      alignment: Alignment(1.0, 1.0),
                                      children: <Widget>[
                                        Container(
                                            height: 250.0,
                                            child:
                                            Swiper(
                                                itemBuilder: (context, index){

                                                  return  FadeInImage.assetNetwork(placeholder: 'Loading_icon.gif', image: widget.shopreco.photoUrl[index], fit: BoxFit.cover, );
                                                },
                                                indicatorLayout: PageIndicatorLayout.COLOR ,

                                                outer: false,
                                                loop: false,
                                                itemCount: widget.shopreco.photoUrl.length,
                                                pagination: SwiperPagination(
                                                    margin: EdgeInsets.only(bottom : 15.0, left: 0.0),
                                                    alignment: Alignment.bottomCenter,
                                                    builder:
                                                    DotSwiperPaginationBuilder(activeColor: Color.fromRGBO(234, 98, 209, 1.0), color: Colors.white, size: 10.0, space: 7.0,  )),

                                                control:  SwiperControl(iconNext: null, iconPrevious: null, color: Colors.pink))
                                        ),

                                        Container(
                                          width: 80.0,
                                          child: Row(
                                            children: <Widget>[
                                              IconButton(icon: (favorcolor) ? Icon(Icons.favorite, color: Color.fromRGBO(234, 98, 209, 1.0),) : Icon(Icons.favorite_border, color: Color.fromRGBO(234, 98, 209, 1.0),) ,
                                                          onPressed: (){
                                                          setState(() {
                                                            if(favorcolor) {
                                                              favorcolor=false;
                                                              favornumm--;
                                                               widget.shopreco.reference.updateData({"favorid" : FieldValue.arrayRemove([revewid]) }) ;

                                                              widget.cuser.reference
                                                                  .updateData({
                                                                "favorshop": FieldValue.arrayRemove(
                                                                    [{
                                                                      'title' : widget.shopreco.shoptitle,
                                                                      'service' : widget.shopreco.shop_class,
                                                                      'photo' : widget.shopreco.photoUrl[0],
                                                                      'refrence' : widget.shopreco.reference, // 이 리뷰의 레퍼런스를 저장해서 다른 위젯에서 여기로 다시 찾아올때 사용함
                                                                    }])
                                                              });

                                                            }
                                                            else {
                                                              favorcolor=true;
                                                              favornumm++;
                                                              widget.shopreco.reference.updateData({"favorid" : FieldValue.arrayUnion([revewid]) }) ;
                                                              widget.cuser.reference
                                                                  .updateData({
                                                                "favorshop": FieldValue.arrayUnion(
                                                                    [{
                                                                      'title' : widget.shopreco.shoptitle,
                                                                      'service' : widget.shopreco.shop_class,
                                                                      'photo' : widget.shopreco.photoUrl[0],
                                                                      'refrence' : widget.shopreco.reference, // 이 리뷰의 레퍼런스를 저장해서 다른 위젯에서 여기로 다시 찾아올때 사용함
                                                                    }])
                                                              });

                                                            }

                                                          });
                                                          }),
                                              Text(favornumm.toString(), style: TextStyle(fontSize: 20.0, color: Colors.white),  ),

                                            ],
                                          ),
                                        )

                                      ],
                                    ),
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
                                                  setState(() {
                                                    colormenu1 =  Color.fromRGBO(227, 101, 180, 1.0);
                                                    colormenu2 = Colors.black;
                                                    colormenu3  = Colors.black;
                                                    shop_contents = Shop_inform(widget.shopreco);
                                                  });

                                                },
                                                splashColor: Colors.pinkAccent[100],
                                                borderRadius: BorderRadius.circular(50.0),
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left : 0.0, top: 10.0, bottom: 10.0),
                                                  child: Container(
                                                    width: 100.0,
                                                    child: Text(
                                                      '정보·위치',
                                                      style: TextStyle(fontSize: 17.0, color: colormenu1), textAlign: TextAlign.center,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    colormenu2 =  Color.fromRGBO(227, 101, 180, 1.0);
                                                     colormenu1 = Colors.black;
                                                    colormenu3  = Colors.black;
                                                    shop_contents = shop_service2(widget.shopreco);

                                                  });

                                                },
                                                splashColor: Colors.pinkAccent[100],
                                                borderRadius: BorderRadius.circular(50.0),

                                                child: Padding(
                                                  padding: const EdgeInsets.only(left : 0.0, top: 10.0, bottom: 10.0),
                                                  child: Container(
                                                    width: 100.0,
                                                    child: Text(
                                                      '서비스·가격',
                                                      style: TextStyle(fontSize: 17.0, color: colormenu2), textAlign: TextAlign.center,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: (){
                                                  setState(() {
                                                    colormenu3 =  Color.fromRGBO(227, 101, 180, 1.0);
                                                    colormenu2 = Colors.black;
                                                    colormenu1  = Colors.black;
                                                    shop_contents = shopreview(widget.shopreco, );

                                                  });

                                                },
                                                splashColor: Colors.pinkAccent[100],
                                                borderRadius: BorderRadius.circular(50.0),
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left : 0.0, top: 10.0, bottom: 10.0),
                                                  child: Container(
                                                    width: 100.0,
                                                    child: Text(
                                                      '담당·후기',
                                                      style: TextStyle(fontSize: 17.0, color: colormenu3), textAlign: TextAlign.center,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ])),
                                  ),

                                  shop_contents,

                                ],

                              ),
                            ),
                          ),
                        ),
                      );}
                  ),
                   Container(
                     height: 70.0,
                     child: AppBar(
                        backgroundColor: Color.fromRGBO(70, 70, 70, 0.4 ),
                        leading: IconButton(icon: Icon(Icons.keyboard_arrow_left, color: Colors.white, size: 30.0,), onPressed:()=> Navigator.pop(context2)),
                        title: Text("${widget.shopreco.shoptitle} 정보", style: TextStyle(fontSize: 20.0, color: Colors.white),),
                      ),
                   ),


                ],
              )));

  }  }



