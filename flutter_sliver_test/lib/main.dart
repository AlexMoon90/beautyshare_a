
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    var srcr = ScrollController();
    List<String> listItems = [];
    for (var i = 0; i < 30; i++) {
      listItems.add('Item ${i}');
    }
    print("몇번 찍히는지 봅시다");

    return new MaterialApp(
      home: new DefaultTabController(
        length: 2,
        child: new Scaffold(
          body: new NestedScrollView(
            dragStartBehavior: DragStartBehavior.start,
            controller:srcr ,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                new SliverAppBar(
                  title: Text("Application"),
                  floating: false,
                  pinned: true,
                  snap: false,
                  bottom: new TabBar(
                    tabs: [
                      new Tab(text: 'tab1'),
                      new Tab(text: 'tab2'),
                    ],
                  ),
                ),
               /*   SliverList(
                    delegate :
                SliverChildListDelegate(
                 [


                  ],
                ) ), */
                SliverList(
                    delegate :
                    SliverChildListDelegate(
                      [
                        Container(
                          child:
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Chip(label: Text("테스트1")),
                              Chip(label: Text("테스트2")),
                              Chip(label: Text("테스트3")),
                            ],
                          ),
                        ),


                         LimitedBox(
                           child: ListView.builder(
                             controller: srcr,
                            itemCount: listItems.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                leading: Container(
                                  width: 50,
                                  height: 50,
                                  color: RandomColor().randomColor(),
                                ),
                                title: Text(listItems[index]),
                              );
                            },
                        ),
                           maxHeight: 1800.0,
                         ),
                      ],
                    ) )

              ];
            },
            body: new TabBarView(

              children: [
                ListView.builder(
                  itemCount: listItems.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: RandomColor().randomColor(),
                      ),
                      title: Text(listItems[index]),
                    );
                  },
                ),
                Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "This is the second screen in the app. As you can see, the top of this text gets hidden",
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 30.0
                      ),
                    )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}