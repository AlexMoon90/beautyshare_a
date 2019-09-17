import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/streams.dart';
import 'package:random_color/random_color.dart';

class Bloc_color {

  List<Color> _collist = [];
  Color color;

  BehaviorSubject<List<Color>> coloradd = BehaviorSubject();
  Observable<List<Color>> get colobserve => coloradd.stream;

  BehaviorSubject buttonadd= BehaviorSubject();
  Observable get buttonobserve => buttonadd.stream;

  BehaviorSubject colorchange = BehaviorSubject();
  Observable get color_observe => colorchange.stream;

  void buttonchange(int index){

    buttonadd.sink.add(index);
  }

   void color_change (Color color) {

    colorchange.sink.add(color);
   }


  void makewidgetlist() {
    RandomColor CC = RandomColor();
    Color colors = CC.randomColor();
    _collist.add(colors);

    coloradd.sink.add(_collist);
  }

  void deletelist(){
    _collist.removeLast();
    coloradd.sink.add(_collist);

  }

void disclose() {
    coloradd.close();

}

}

