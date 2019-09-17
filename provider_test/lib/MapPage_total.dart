import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'Bloc_mylocation.dart';
import 'package:provider/provider.dart';
import 'Bloc_database.dart';

class MapPage_total extends StatefulWidget {

  final List<Model_shopinfor> models;
  final double distance_fromCenter ;

  MapPage_total(this.models, this.distance_fromCenter);

  @override
  State<StatefulWidget> createState() {
    return new MapPage_totalState();
  }
}

class MapPage_totalState extends State<MapPage_total> {
  @override
  Completer<GoogleMapController> _controller = Completer();
  LatLng _lastposition;
  double zoom ;
  CameraPosition _cameraPosition;
  Bloc_database bloc;
  Bloc_mylocation loca;
  var _bounds;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    zoom = 13.0;

    bloc = Provider.of<Bloc_database>(context, listen: false);
    loca = Provider.of<Bloc_mylocation>(context, listen: false);

 /* _bounds=  LatLngBounds(

      southwest: LatLng(loca.mylocation.latitude-0.00909438*widget.distance_fromCenter, loca.mylocation.longitude+0.011268875*widget.distance_fromCenter),
      northeast:  LatLng(loca.mylocation.latitude+0.00909438*widget.distance_fromCenter, loca.mylocation.longitude-0.011268875*widget.distance_fromCenter)); */

    _lastposition= LatLng(loca.mylocation.latitude, loca.mylocation.longitude);
    _cameraPosition=   CameraPosition(
      target: _lastposition,
      zoom: widget.distance_fromCenter
    )

    ;

  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void zoomIn() async {
    zoom++;
    GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(_lastposition, zoom));
    print(zoom.toString());
  }

  void zoomOut() async {
    zoom--;
    GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(_lastposition, zoom));
    print(zoom.toString());
  }

  void _onCameraMove(CameraPosition position) {
    _lastposition = position.target;
  }

  @override
  Widget build(BuildContext context) {
    Bloc_mylocation bloc_mylocation =
    Provider.of<Bloc_mylocation>(context, listen: false);

    LatLng _center = _lastposition;
    Set<Marker> _marker = {};

    for (int i =0 ; i < widget.models.length; i++) {
      _marker.add(Marker(
        markerId: MarkerId(widget.models[i].id.toString()),
        position: LatLng(widget.models[i].lat, widget.models[i].long),
        infoWindow: InfoWindow(
          title: widget.models[i].name,
          snippet: widget.models[i].phone,
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    }

    print('marker :  ${_marker.length}');


    return Scaffold(
        appBar: AppBar(
          title: Text('구글지도보기'),
        ),
        body: Stack(
          alignment: Alignment(1.0, 1.0),
          children: <Widget>[
            Container(

              child: GoogleMap(
                cameraTargetBounds: CameraTargetBounds(_bounds),
                onMapCreated: _onMapCreated,
                initialCameraPosition: _cameraPosition,
                markers: _marker,
                myLocationEnabled: true,

              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  FloatingActionButton(
                    onPressed: zoomIn,
                    child: Icon(Icons.zoom_in, size : 40.0),
                    heroTag: 'zoomin',
                  ),
                  FloatingActionButton(
                    onPressed: zoomOut,
                    child: Icon(Icons.zoom_out, size: 40.0,),
                    heroTag: 'zoomout',
                  ),

                ],
              ),
            )


          ],
        ));
  }
}