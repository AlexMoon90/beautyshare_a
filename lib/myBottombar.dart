import 'package:flutter/material.dart';
import 'package:beautyshare_a/Usage/Usagepage.dart';
import 'Mainpage.dart';
import 'package:beautyshare_a/Promotion/Promotionpage.dart';
import 'package:beautyshare_a/Location/Locationpage.dart';
import 'package:beautyshare_a/Myinform/Myinformain.dart';


Widget myBottombar_usage (BuildContext context1)
{
  Color botoomcolor = Color.fromRGBO(227, 101, 180, 1.0);

return BottomAppBar(
elevation: 8.0,
child: Padding(
padding: const EdgeInsets.only(top: 5.0, bottom: 5.0, right: 5.0),
child: Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
mainAxisSize: MainAxisSize.max,
crossAxisAlignment: CrossAxisAlignment.center ,
children: <Widget>[
IconButton(
onPressed: () {Navigator.pop(context1);},
icon: ImageIcon( AssetImage('backbutton.png'), color: botoomcolor, size: 20.0,),

),
IconButton(

  onPressed: () {Navigator.push(context1, MaterialPageRoute(builder: (context1) => Mainpage()));},
  icon: ImageIcon( AssetImage('images/home.png', ), color: botoomcolor,  ),
),
IconButton(
  onPressed: () {Navigator.push(context1, MaterialPageRoute(builder: (context1) => Locationpage() ));},
  icon: ImageIcon( AssetImage('images/map.png',), color: botoomcolor, ),),
IconButton(
  onPressed: () {Navigator.push(context1, MaterialPageRoute(builder: (context1) => Promotionpage()));},
  icon: ImageIcon( AssetImage('images/promotion.png'), color:botoomcolor ),),
IconButton(
  onPressed: () {Navigator.push(context1, MaterialPageRoute(builder: (context1) => myinform_main() ));},
  icon: ImageIcon( AssetImage('images/mypage.png'), color:botoomcolor, ),),

],
),
));
}


Widget myBottombar_location (BuildContext context1)
{
  Color botoomcolor = Color.fromRGBO(227, 101, 180, 1.0);

  return BottomAppBar(
      elevation: 8.0,

      child: Padding(
        padding: const EdgeInsets.only(top:5.0, bottom:5.0, right: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            IconButton(
              onPressed: () {Navigator.pop(context1);},
              icon: ImageIcon( AssetImage('images/backbutton.png'), color: botoomcolor, size: 20.0,),

            ),
            IconButton(

              onPressed: () {Navigator.push(context1, MaterialPageRoute(builder: (context1) => Mainpage()));},
              icon: ImageIcon( AssetImage('images/home.png'), color: botoomcolor, ),

            ),
            IconButton(
              onPressed: () {Navigator.push(context1, MaterialPageRoute(builder: (context1) => Usagepage()));},
              icon: ImageIcon( AssetImage('images/review.png',), color: botoomcolor ),),
            IconButton(
              onPressed: () {Navigator.push(context1, MaterialPageRoute(builder: (context1) => Promotionpage()));},
              icon: ImageIcon( AssetImage('images/promotion.png'), color:botoomcolor ),),
            IconButton(
              onPressed: () {Navigator.push(context1, MaterialPageRoute(builder: (context1) => myinform_main()));},
              icon: ImageIcon( AssetImage('images/mypage.png'), color:botoomcolor, ),),

          ],
        ),
      ));
}

Widget myBottombar_promotion (BuildContext context1)
{
  Color botoomcolor = Color.fromRGBO(227, 101, 180, 1.0);

  return BottomAppBar(
      elevation: 100.0,
      child: Padding(
        padding: const EdgeInsets.only(right: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            IconButton(
              onPressed: () {Navigator.pop(context1);},
              icon: ImageIcon( AssetImage('images/backbutton.png'), color: botoomcolor, size: 20.0,),

            ),
            IconButton(

              onPressed: () {Navigator.push(context1, MaterialPageRoute(builder: (context1) => Mainpage()));},
              icon: ImageIcon( AssetImage('images/home.png'), color: botoomcolor, ),

            ),
            IconButton(
              onPressed: () {Navigator.push(context1, MaterialPageRoute(builder: (context1) => Usagepage()));},
              icon: ImageIcon( AssetImage('images/review.png',), color: botoomcolor ),),
            IconButton(
              onPressed: () {Navigator.push(context1, MaterialPageRoute(builder: (context1) => Locationpage()));},
              icon: ImageIcon( AssetImage('images/map.png'), color:botoomcolor ),),
            IconButton(
              onPressed: () {Navigator.push(context1, MaterialPageRoute(builder: (context1) => myinform_main()));},
              icon: ImageIcon( AssetImage('images/mypage.png'), color:botoomcolor, ),),

          ],
        ),
      ));
}

