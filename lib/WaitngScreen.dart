import 'package:flutter/material.dart';
import 'dart:async';
import 'Root_page.dart';

class waitingScreen extends StatefulWidget {
  @override
  _waitingScreenState createState() => _waitingScreenState();
}

class _waitingScreenState extends State<waitingScreen> {


  @override
  Widget build(BuildContext context) {



    return   MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(

          body: Stack(
            alignment: Alignment(0, 0),
            children: <Widget>[
              Container(
                decoration: BoxDecoration(color: Color.fromRGBO(227, 101, 180, 1.0)),
              ),
              CircularProgressIndicator(),
            ],
          ),
        ),
    )

      ;
  }
}
