import 'package:flutter/material.dart';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:beautyshare_a/Usage/Usagepage.dart';
import 'package:beautyshare_a/Usage/Usage_list.dart';
import 'package:beautyshare_a/Location/Locationpage.dart';
import 'package:beautyshare_a/Location/Location_list.dart';
import 'package:beautyshare_a/Myinform/My_inform.dart';
import 'package:beautyshare_a/Myinform/My_regular.dart';
import 'package:beautyshare_a/Myinform/My_reservation.dart';
import 'package:beautyshare_a/Myinform/My_point.dart';
import 'package:beautyshare_a/Myinform/My_coupon.dart';
import 'package:beautyshare_a/Myinform/Favorite_review.dart';
import 'package:beautyshare_a/Model/User_Provider.dart';
import 'package:beautyshare_a/Model/model_user.dart';
import 'package:beautyshare_a/Myinform/Favorite_shop.dart';



class myinform_main extends StatelessWidget {
  
  int bpoint = 5000;
  int bcoupon = 2;
  int myreview= 3;
  var f =  NumberFormat("###,###,###");



  @override
  Widget build(BuildContext context) {
    var data_fr = UserProvider.of(context).bloc;
    var listscroll = ScrollController();
    return
    Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.1,
          leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: ()=>Navigator.pop(context)),
          title: Text('내정보'),


        ),
        body:

        ListView(
        controller: listscroll,
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[

             /*     Padding(
                    padding: const EdgeInsets.only(top: 20.0 ),
                    child: Center(
                      child:  FutureBuilder(
                          future : SharedPreferences.getInstance(),
                          builder: (context, snapshot) {

                            return UserAccountsDrawerHeader(
                                accountName: Text(snapshot.data.getString('displayName')),
                                accountEmail : Text(snapshot.data.getString('email')),
                                currentAccountPicture: GestureDetector(
                                  onTap: () {},
                                  child: CircleAvatar(
                                      backgroundImage: NetworkImage(snapshot.data.getString('photoUrl'))
                                  ),
                                ),

                                decoration: BoxDecoration(color: Colors.white
                                )
                            );

                          }),
                    ),
                  ), */

                  Padding(
                    padding: const EdgeInsets.only (top: 15.0),
                    child: Container(
                      height: 70.0,
                      color: Color.fromRGBO(234, 98, 209, 1.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {Navigator.push(context, MaterialPageRoute( builder: (context) => my_point(bpoint)));},
                            child: Container(
                              width : 100.0,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Text ('${f.format(bpoint)} P', style: TextStyle(color: Colors.white, fontSize: 18.0),),
                                  ),
                                  Text('포인트 ', style: TextStyle(color: Colors.white, fontSize: 18.0)),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => my_coupon()));},
                            child: Container(
                              width : 100.0,

                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text ('${f.format(bcoupon)} 개', style: TextStyle(color: Colors.white, fontSize: 18.0),),
                                  Text('내쿠폰 ', style: TextStyle(color: Colors.white, fontSize: 18.0)),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            child: Container(
                              width : 100.0,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,

                                children: <Widget>[
                                  Text ('${f.format(myreview)} 건', style: TextStyle(color: Colors.white, fontSize: 18.0),),
                                  Text('내후기 ', style: TextStyle(color: Colors.white, fontSize: 18.0)),
                                ],
                              ),
                            ),
                          ),




                        ],

                      ),
                    ),
                  ),

                  Container(
                    height: 60.0,
                   // decoration: BoxDecoration(border: Border.all() ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("공지사항", style: TextStyle(fontSize: 18.0),),
                          IconButton(icon: Icon(Icons.arrow_forward_ios), onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => my_inform()));}),

                        ],
                      ),
                    ),
                  ),
                  Divider(),
                  Container(
                    height: 60.0,
                    // decoration: BoxDecoration(border: Border.all() ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("내단골샵", style: TextStyle(fontSize: 18.0),),
                          IconButton(icon: Icon(Icons.arrow_forward_ios), onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => my_regular()));}),


                        ],
                      ),
                    ),
                  ),
                  Divider(),
                  Container(
                    height: 60.0,
                    // decoration: BoxDecoration(border: Border.all() ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("예약내역", style: TextStyle(fontSize: 18.0),),
                          IconButton(icon: Icon(Icons.arrow_forward_ios), onPressed:() {Navigator.push(context, MaterialPageRoute(builder: (context) => my_reservation()));}),

                        ],
                      ),
                    ),
                  ),
                  Divider(),

                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 13.0, right: 30.0),
                      child:
                     StreamBuilder(
                          stream: data_fr.reference.snapshots(),
                          builder: (context, snapshot) {
                          if (!snapshot.hasData)
                          return CircularProgressIndicator();

                          else {

                            var user = Favor_review.fromsnapshot(snapshot.data);
                            double h, hh;

                            if (user.favorreview != null) {
                              h = ((user.favorreview.length)%2==0) ? ((user.favorreview.length) ~/ 2 ) * 225.0 : ((user.favorreview.length) ~/ 2 +
                                1.0) * 225.0 ; }
                                else { h = 0.0; }

                             if(user.favorshop != null) {
                                hh = ((user.favorshop.length)% 2 ==0) ? ((user.favorshop.length) ~/ 2 ) * 225.0 : ((user.favorshop.length) ~/ 2 +
                          1.0) * 225.0 ; }
                            else {hh =0.0; }

                        return Column(
                          children: <Widget>[
                                      ExpansionTile( initiallyExpanded: true,
                                              title: Text("관심후기", style: TextStyle(fontSize: 18.0, color: Colors.black87),),
                                              children: <Widget>[
                                      Padding(  padding: const EdgeInsets.only(left :15.0),
                                      child:  Container (
                                             height: h,
                                              width: 500.0,
                                               child : favorite_review(user.favorreview, listscroll, h)   )
                                      ),]
                                      ),


                            ExpansionTile(
                              initiallyExpanded: true,
                              title: Text("관십샵", style: TextStyle(fontSize: 18.0, color: Colors.black87),),
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left :15.0),
                                  child:  Container(
                                            height: hh,
                                            width: 500.0,
                                            child: favorite_shop(user.favorshop, listscroll, hh)),

                                ),
                              ],
                            ),


                          ],
                        );
                      } } ),


                    ),
                  ),
                  Divider(),

                ],
              ),
            ),
          ],

        )
        ,

      )


      ;
  }


}