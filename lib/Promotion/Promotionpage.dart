import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:beautyshare_a/myAppbar.dart';
import 'package:beautyshare_a/myBottombar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Promotionlist.dart';
import 'package:beautyshare_a/myBolottomnavgiationBar.dart';


CollectionReference ref_loca = Firestore.instance.collection("Promotion");

Stream<QuerySnapshot> loca_class (String usageclass) {

  return  ref_loca.where("shop_class",arrayContains : "$usageclass").snapshots();
}


class Promotionpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: DefaultTabController(
      initialIndex: 0,
      length: 6,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(110.0),
          child: appbarUsage4(),
          // Appbar 불러오기
        ),
        body: TabBarView(children: [
          promotion_list(ref_loca.snapshots()),
          promotion_list(loca_class("헤어")),
          promotion_list(loca_class("네일")),
          promotion_list(loca_class("스킨")),
          promotion_list(loca_class("메이크업")),
          promotion_list(loca_class("기타")),


        ]),

        bottomNavigationBar: myNavigationbar_prom(context),
      ),
    ));
  }
}
