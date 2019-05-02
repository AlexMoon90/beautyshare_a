import 'package:flutter/material.dart';


Widget tabbar =   TabBar(
        indicatorSize: TabBarIndicatorSize.label,
        indicatorWeight: 3.0,
        isScrollable: true,
  labelColor:  Color.fromRGBO(234, 98, 209, 1.0),

  unselectedLabelColor :  Colors.black,
  indicatorColor:  Color.fromRGBO(234, 98, 209, 1.0),
        indicatorPadding: EdgeInsets.only(bottom: 0.0),
        tabs: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Text(
              '전체',
              style: TextStyle(fontSize: 14.0,),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Text(
              '헤어',
              style: TextStyle(fontSize: 14.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Text(
              '네일',
              style: TextStyle(fontSize: 14.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Text(
              '스킨',
              style: TextStyle(fontSize: 14.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Text(
              '메이크업',
              style: TextStyle(fontSize: 14.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Text(
              '속눈썹',
              style: TextStyle(fontSize: 14.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Text(
              '왁싱',
              style: TextStyle(fontSize: 14.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Text(
              '기타',
              style: TextStyle(fontSize: 14.0),
            ),
          ),
        ],
      );


Widget tabbar_promotion= TabBar (
  indicatorSize: TabBarIndicatorSize.label,
  isScrollable: true ,
  labelColor:  Color.fromRGBO(234, 98, 209, 1.0),
  unselectedLabelColor :  Colors.black,
  indicatorColor:  Color.fromRGBO(234, 98, 209, 1.0),

  indicatorPadding: EdgeInsets.only(bottom: 0.0),

  tabs: [
    Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Text(
        '전체',
        style: TextStyle(fontSize: 14.0, ),
      ),
    ),
    Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Text(
        '헤어',
        style: TextStyle(fontSize: 14.0),
      ),
    ),
    Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Text(
        '네일',
        style: TextStyle(fontSize: 14.0),
      ),
    ),
    Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Text(
        '스킨',
        style: TextStyle(fontSize: 14.0),
      ),
    ),
    Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Text(
        '메이크업',
        style: TextStyle(fontSize: 14.0),
      ),
    ),

    Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Text(
        '기타',
        style: TextStyle(fontSize: 14.0),
      ),
    ),
  ],
) ;