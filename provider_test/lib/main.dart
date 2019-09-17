import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'BlocCart.dart';
import 'Bloc_mylocation.dart';
import 'Myhome.dart';
import 'Bloc_googleaddress.dart';
import 'Bloc_database.dart';


void main() => runApp(
 MyApp(),
);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(builder: (context) => Bloc_color()),
        Provider(builder: (context) => Bloc_cart()),
        Provider(builder: (context) => Bloc_avatar()),
        Provider(builder: (context) => Bloc_mylocation()),
        Provider(builder: (context) => Bloc_googleaddress()),
        Provider(builder: (context) => Bloc_database()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:  MyHomePage(title: 'Flutter Demo Home Page'),

      ),
    );
  }
}

