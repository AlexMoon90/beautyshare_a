import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'Bloc_mylocation.dart';
import 'package:provider/provider.dart';
import 'Bloc_database.dart';

class MapPage extends StatefulWidget {
  final Model_shopinfor model;

  MapPage(this.model);

  @override
  State<StatefulWidget> createState() {
    return new MapPageState();
  }
}

class MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController mapController;
  LatLng _lastposition;
  double zoom;
  CameraPosition _cameraPosition;
  Set<Marker> _marker = {};
  LatLng _center;
  LatLng _center2 = LatLng(37.301668, 127.113861);
  Marker marker;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    zoom = 16.0;
    _center = LatLng(widget.model.lat, widget.model.long);
    _lastposition = LatLng(widget.model.lat, widget.model.long);
    _cameraPosition = CameraPosition(
      target: _lastposition,
      zoom: zoom,
    );
    marker = Marker(onTap: () {

      _marker.remove(marker);

      print ('marker 갯수 : ${_marker.length}');

      setState(() {

        _marker.add(Marker(

          markerId: MarkerId(widget.model.toString()),
          position: _center,
          infoWindow: InfoWindow(
            title: widget.model.name,
            // snippet: widget.model.phone,
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(100.0),
        ));
      });
    },
      markerId: MarkerId(widget.model.toString()),
      position: _center,
      infoWindow: InfoWindow(
        title: widget.model.name,
        snippet: widget.model.phone,
      ),
      icon: BitmapDescriptor.defaultMarker,
    );
    _marker.add(marker );


  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void zoomIn() async {
    zoom++;
    GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(
        LatLng(widget.model.lat, widget.model.long), zoom));
    print(zoom.toString());
  }

  void zoomOut() async {
    zoom--;
    GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(
        LatLng(widget.model.lat, widget.model.long), zoom));
    print(zoom.toString());
  }

  void _onCameraMove(CameraPosition position) {
    _lastposition = position.target;
  }

  void changeMarker() async {
    GoogleMapController controller = await _controller.future;

  }

  @override
  Widget build(BuildContext context) {
    Bloc_mylocation bloc_mylocation =
        Provider.of<Bloc_mylocation>(context, listen: false);


    return Scaffold(
        appBar: AppBar(
          title: Text('구글지도보기'),
        ),
        body: Stack(
          alignment: Alignment(1.0, 1.0),
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              child: GoogleMap(

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
                    child: Icon(Icons.zoom_in, size: 40.0),
                    heroTag: 'zoomin',
                  ),
                  FloatingActionButton(
                    onPressed: zoomOut,
                    child: Icon(
                      Icons.zoom_out,
                      size: 40.0,
                    ),
                    heroTag: 'zoomout',
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
