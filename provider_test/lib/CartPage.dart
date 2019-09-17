import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'BlocCart.dart';
import 'package:avataaar_image/avataaar_image.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  Bloc_color bloc;
  Bloc_cart bloccart;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc = Provider.of<Bloc_color>( context, listen: false);
    bloccart = Provider.of<Bloc_cart>(context, listen: false);
    print('context : $context');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

print (context) ;

    return Scaffold(

      appBar: AppBar(title: Text('장바구니'),
          actions: [
            Padding(
              padding: const EdgeInsets.only (right : 15.0, top : 0.0 ),
              child: Row(
                children: <Widget>[

                  IconButton(icon: Icon(Icons.shopping_cart, color: Colors.amber,size: 35.0,)),
                  StreamBuilder(
                      stream: bloccart.cartobserve,
                      builder: (context1, snapshot) {
                        if (!snapshot.hasData)
                          return Container();

                        else if (snapshot.hasData)
                          return snapshot.data.length == 0 ?

                          Container()

                              :
                          Hero(
                            tag : "fine",
                            child:
                            Stack(
                              alignment: Alignment(0.0, 0.0),
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                                  width: 30.0,
                                  height: 30.0,
                                ),
                                Text(
                                  '${snapshot.data.length}',
                                  style: TextStyle(fontSize: 15.0, decorationStyle: TextDecorationStyle.double),
                                ),
                              ],
                            ),
                          );
                      }),

                ],
              ),
            ),

          ]
      ),
      body: StreamBuilder(
        stream: bloccart.cartobserve,
        builder: (context, snapshot) {
    if(!snapshot.hasData) {return Container(); }
    else if (snapshot.hasData) {
          return  ListView.builder(  itemCount :snapshot.data.length ??=0, itemBuilder: (context, index)
          {

            if(snapshot.data[index]['Class'])  {
              return
            Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: (){bloc.color_change(snapshot.data[index]['Color']) ; },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: 50.0,
                    width: 50.0,
                    color: snapshot.data[index]['Color'],
                  ),
                  Text(snapshot.data[index]['Color'].toString()),

                  RawMaterialButton(onPressed: (){ bloccart.delcart(index); } , child: Text('삭제'),)
                ],
              ),
            ),
          );  }
          else if (!snapshot.data[index]['Class']) {
              return
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: (){ },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        AvataaarImage(
                          avatar: snapshot.data[index]['Avar'],
                          errorImage: Icon(Icons.error),
                          placeholder: CircularProgressIndicator(),
                          width: 80.0,
                        ),
                        Text(snapshot.data[index]['Name']),

                        RawMaterialButton(onPressed: (){ bloccart.delcart(index); } , child: Text('삭제'),)
                      ],
                    ),
                  ),
                );

            }
          } );};
        }
      ),
    );
  }
}
