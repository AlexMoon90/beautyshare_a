import 'package:flutter/material.dart';
import 'package:beautyshare_a/Myinform/My_reservation.dart';
import 'package:beautyshare_a/Myinform/My_point.dart';
import 'package:beautyshare_a/Myinform/My_inform.dart';
import 'My_coupon.dart';
import 'My_setting.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:beautyshare_a/Model/User_Provider.dart';



class mydrawer extends StatelessWidget {
  final BuildContext context2;
  mydrawer(this.context2);

  @override
  Widget build(BuildContext context) {
    var cuser = UserProvider
        .of(context)
        .bloc;


    return Drawer(

      child: ListView(
        children: <Widget>[

          UserAccountsDrawerHeader(
              accountName: Text(cuser.displayName),
              accountEmail: Text(cuser.email),
              currentAccountPicture: GestureDetector(
                onTap: () {},
                child: CircleAvatar(
                    backgroundImage: NetworkImage(cuser.photoUrl)
                ),
              ),
              otherAccountsPictures: <Widget>[
                IconButton(icon: Icon(Icons.clear),
                    onPressed: () => Navigator.of(context).pop()
                )

              ],

              decoration: BoxDecoration(color: Colors.white

              )
          ),


          ListTile(
              title: new Text("내 예약"),
              trailing: new Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigator.of(context).pop();
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => my_reservation()));
              }
          ),
          Divider(),
          new ListTile(
              title: new Text("포인트"),
              trailing: new Icon(Icons.arrow_forward_ios),
              onTap: () {
                //    Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => my_point(5000)));
              }
          ),
          new Divider(),
          new ListTile(
              title: new Text("내 쿠폰"),
              trailing: new Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => my_coupon()));
              }
          ),
          Divider(),
          new ListTile(
              title: new Text("공지사항"),
              trailing: new Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => my_inform()));
              }
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(icon: Icon(Icons.settings),
                  onPressed: () =>
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => my_setting()))),
              Text("설정")
            ],
          )
        ],
      ),
    );
  }

}