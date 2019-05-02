import 'package:flutter/material.dart';
import 'package:beautyshare_a/Usage/Usagepage.dart';
import 'Mainpage.dart';
import 'package:beautyshare_a/Promotion/Promotionpage.dart';
import 'package:beautyshare_a/Location/Locationpage.dart';
import 'package:beautyshare_a/Myinform/Myinformain.dart';


Widget myNavigationbar_usage (BuildContext context1)
{
  Color botoomcolor = Color.fromRGBO(234, 98, 209, 1.0);
  int _selectedIndex = 1;

 void _onitemTapped (int index) {
switch (index) {
  case 0 : { Navigator.pop(context1);}
  break;
  case 1 : {Navigator.push(context1, MaterialPageRoute(builder: (context1) => Mainpage()));}
  break;
  case 2 : {Navigator.push(context1, MaterialPageRoute(builder: (context1) => Locationpage() ));}
  break;
  case 3 : {Navigator.push(context1, MaterialPageRoute(builder: (context1) => Promotionpage()));}
  break;
  case 4 : {Navigator.push(context1, MaterialPageRoute(builder: (context1) => myinform_main() ));}
  break;
}
  }


  return BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(icon: Padding(
                  padding: const EdgeInsets.only (top: 5.0),
                  child: ImageIcon( AssetImage('images/backbutton.png'), color: botoomcolor, size: 25.0,),
                ), title: Padding(
                  padding: const EdgeInsets.only(top :0.0),
                  child: Text('뒤로', style: TextStyle(color: botoomcolor, fontSize: 13.0),),
                )),
                BottomNavigationBarItem(icon: ImageIcon( AssetImage('images/home.png'), color: botoomcolor, ), title: Text('홈으로',style: TextStyle(color: botoomcolor),)),
                BottomNavigationBarItem(icon: ImageIcon( AssetImage('images/map.png',), color: botoomcolor ), title: Text('내주변샵',style: TextStyle(color: botoomcolor),)),
                BottomNavigationBarItem(icon: ImageIcon( AssetImage('images/promotion.png'), color:botoomcolor ), title: Text('프로모션',style: TextStyle(color: botoomcolor),)),
                BottomNavigationBarItem(icon: ImageIcon( AssetImage('images/mypage.png'), color:botoomcolor, ), title: Text('내정보',style: TextStyle(color: botoomcolor),)),

              ],
              type: BottomNavigationBarType.fixed,
              fixedColor: Colors.deepPurple,
              onTap: _onitemTapped,
            );
}

Widget myNavigationbar_loca (BuildContext context1)
{
  Color botoomcolor = Color.fromRGBO(234, 98, 209, 1.0);
  int _selectedIndex = 1;

  void _onitemTapped (int index) {
    switch (index) {
      case 0 : { Navigator.pop(context1);}
      break;
      case 1 : {Navigator.push(context1, MaterialPageRoute(builder: (context1) => Mainpage()));}
      break;
      case 2 : {Navigator.push(context1, MaterialPageRoute(builder: (context1) => Usagepage() ));}
      break;
      case 3 : {Navigator.push(context1, MaterialPageRoute(builder: (context1) => Promotionpage()));}
      break;
      case 4 : {Navigator.push(context1, MaterialPageRoute(builder: (context1) => myinform_main() ));}
      break;
    }
  }


  return BottomNavigationBar(
    items: <BottomNavigationBarItem>[
      BottomNavigationBarItem(icon: Padding(
        padding: const EdgeInsets.only (top: 5.0),
        child: ImageIcon( AssetImage('images/backbutton.png'), color: botoomcolor, size: 25.0,),
      ), title: Padding(
        padding: const EdgeInsets.only(top :0.0),
        child: Text('뒤로', style: TextStyle(color: botoomcolor),),
      )),
      BottomNavigationBarItem(icon: ImageIcon( AssetImage('images/home.png'), color: botoomcolor, ), title: Text('홈으로',style: TextStyle(color: botoomcolor),)),
      BottomNavigationBarItem(icon: ImageIcon( AssetImage('images/review.png',), color: botoomcolor ), title: Text('이용후기',style: TextStyle(color: botoomcolor),)),
      BottomNavigationBarItem(icon: ImageIcon( AssetImage('images/promotion.png'), color:botoomcolor ), title: Text('프로모션',style: TextStyle(color: botoomcolor),)),
      BottomNavigationBarItem(icon: ImageIcon( AssetImage('images/mypage.png'), color:botoomcolor, ), title: Text('내정보',style: TextStyle(color: botoomcolor),)),

    ],
    type: BottomNavigationBarType.fixed,
    onTap: _onitemTapped,
  );
}

Widget myNavigationbar_prom (BuildContext context1)
{
  Color botoomcolor = Color.fromRGBO(234, 98, 209, 1.0);
  int _selectedIndex = 1;

  void _onitemTapped (int index) {
    switch (index) {
      case 0 : { Navigator.pop(context1);}
      break;
      case 1 : {Navigator.push(context1, MaterialPageRoute(builder: (context1) => Mainpage()));}
      break;
      case 2 : {Navigator.push(context1, MaterialPageRoute(builder: (context1) => Usagepage() ));}
      break;
      case 3 : {Navigator.push(context1, MaterialPageRoute(builder: (context1) => Locationpage()));}
      break;
      case 4 : {Navigator.push(context1, MaterialPageRoute(builder: (context1) => myinform_main() ));}
      break;
    }
  }


  return BottomNavigationBar(
    items: <BottomNavigationBarItem>[
      BottomNavigationBarItem(icon: Padding(
        padding: const EdgeInsets.only (top: 5.0),
        child: ImageIcon( AssetImage('images/backbutton.png'), color: botoomcolor, size: 25.0,),
      ), title: Padding(
        padding: const EdgeInsets.only(top :0.0),
        child: Text('뒤로', style: TextStyle(color: botoomcolor),),
      )),
      BottomNavigationBarItem(icon: ImageIcon( AssetImage('images/home.png'), color: botoomcolor, ), title: Text('홈으로',style: TextStyle(color: botoomcolor),)),
      BottomNavigationBarItem(icon: ImageIcon( AssetImage('images/review.png',), color: botoomcolor ), title: Text('이용후기',style: TextStyle(color: botoomcolor),)),
      BottomNavigationBarItem(icon: ImageIcon( AssetImage('images/map.png'), color:botoomcolor ), title: Text('내주변샵',style: TextStyle(color: botoomcolor),)),
      BottomNavigationBarItem(icon: ImageIcon( AssetImage('images/mypage.png'), color:botoomcolor, ), title: Text('내정보',style: TextStyle(color: botoomcolor),)),

    ],
    type: BottomNavigationBarType.fixed,
    onTap: _onitemTapped,
  );
}