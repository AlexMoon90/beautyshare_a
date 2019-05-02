import 'package:flutter/material.dart';

class my_inform extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return

      Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.1,
          leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: ()=>Navigator.pop(context)),
          title: Text('공지사항'),


        ),      );
  }

}