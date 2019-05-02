import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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
import 'package:beautyshare_a/Model/model_shopinfo.dart';


CollectionReference stylist_ref= Firestore.instance.collection("Beautyshop");
var beautyshop_in = stylist_ref.snapshots();


class Shopinfor2 extends StatefulWidget {


  final Record_loca shopreco;
  final Stream<QuerySnapshot> styleshot;
  Shopinfor2( this.shopreco, this.styleshot) ;
  _Shopinfor2state createState() => _Shopinfor2state();
}


class _Shopinfor2state extends State <Shopinfor2> with SingleTickerProviderStateMixin {
  ScrollController _scrollViewController;
  TabController _tabController;

  Widget shop_contents;
  @override
  void initState() {
    // TODO: implement initState

    _scrollViewController = new ScrollController();
    _tabController = new TabController(vsync: this, length: 3);

    shop_contents = Shop_inform(widget.shopreco);


    super.initState();
  }


  @override

  Widget build(BuildContext context2) {
    // TODO: implement build


    return
      MaterialApp(
          debugShowCheckedModeBanner: false,

          home :  Scaffold(


              floatingActionButton: Fancybutton2("예약하기",(){}),
              floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
              body:


              CustomScrollView(

                  slivers: <Widget> [


                      Column (
                        children  : [
                          SafeArea(
                            child: Stack(
                              alignment: Alignment(-1.0, -1.0),
                              children: <Widget>[
                                Container(
                                    height: 250.0,
                                    child:
                                    Swiper(
                                        itemBuilder: (context, index){

                                          return  FadeInImage.assetNetwork(placeholder: 'Loading_icon.gif', image: widget.shopreco.photoUrl[index], fit: BoxFit.cover, );
                                        },
                                        indicatorLayout: PageIndicatorLayout.WARM ,

                                        outer: false,
                                        loop: false,
                                        itemCount: widget.shopreco.photoUrl.length,
                                        pagination: SwiperPagination(
                                            margin: EdgeInsets.only(bottom : 15.0, left: 0.0),
                                            alignment: Alignment.bottomCenter,
                                            builder:
                                            DotSwiperPaginationBuilder(activeColor: Colors.pink[300], color: Colors.pink[100], size: 10.0, space: 7.0,  )),

                                        control:  SwiperControl(iconNext: null, iconPrevious: null, color: Colors.pink))
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
                            ),
                          ),
                        ],

                      ),


                      SliverAppBar(
                        pinned: false,
                        floating: false,
                        bottom: new TabBar(
                          tabs: <Tab>[
                             Tab(
                              child: Text("정보 위치"),
                            ),
                             Tab(
                               child: Text("서비스 가격"),
                             ),
                             Tab(
                               child: Text("직원 후기"),
                             ),
                          ],
                          controller: _tabController,
                        ),
                      ),

                      SliverFillRemaining(
                        child: TabBarView(
                          controller: _tabController,
                          children: <Widget>[
                            Text("Tab 1"),
                            Text("Tab 2"),
                            Text("Tab 3"),
                          ],
                        ),
                      ),


                ] ),


              ));

  }  }


