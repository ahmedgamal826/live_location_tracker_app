import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

import 'package:live_location_tracking_22/models/place_model.dart';
import 'package:live_location_tracking_22/widgets/show_snack_bar.dart';
import 'package:location/location.dart';

class CustomGoogleMaps extends StatefulWidget {
  const CustomGoogleMaps({super.key});

  @override
  State<CustomGoogleMaps> createState() => _CustomGoogleMapsState();
}

class _CustomGoogleMapsState extends State<CustomGoogleMaps> {
  late CameraPosition initialCameraPosition;
  GoogleMapController? googleMapController;
  bool isMapReady = false;

  late Location location;

  @override
  void initState() {
    initialCameraPosition = const CameraPosition(
      target: LatLng(30.29773520757277, 31.301290699998926),
      zoom: 3,
    );

    super.initState();
    initMarkers();
    initPolyLines();
    initPolygons();
    initCircles();

    location = Location();

    checkAndRequestLocationService();
  }

  @override
  void dispose() {
    googleMapController?.dispose();
    super.dispose();
  }

  Set<Marker> markers = {};
  Set<Polyline> polyLines = {};
  Set<Polygon> polygons = {};
  Set<Circle> circles = {};

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          polygons: polygons,
          polylines: polyLines,
          circles: circles,
          markers: markers,
          zoomControlsEnabled: true,
          onMapCreated: (controller) {
            googleMapController = controller; // googleMapController Initialized
            isMapReady = true;
            initialMapStyle();
          },
          initialCameraPosition: initialCameraPosition,
        ),
        Positioned(
          bottom: 16,
          right: 16,
          left: 16,
          child: ElevatedButton(
            onPressed: () {
              if (isMapReady && googleMapController != null) {
                LatLng latLng = LatLng(16.76948812513405, 48.799466686797125);

                googleMapController!.animateCamera(
                  CameraUpdate.newLatLng(latLng),
                );
              }
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Change Location',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void initialMapStyle() async {
    var nightStyle = await DefaultAssetBundle.of(context)
        .loadString('assets/map_styles/night_map_style.json');

    if (isMapReady && googleMapController != null) {
      googleMapController!.setMapStyle(nightStyle);
    }
  }

  Future<Uint8List> getImageFromRowData(String image, double width) async {
    var imageData = await rootBundle.load(image);

    var imageCodec = await ui.instantiateImageCodec(
      imageData.buffer.asUint8List(),
      targetWidth: width.round(),
    );

    var imageFrameInfo = await imageCodec.getNextFrame();

    var imageByData =
        await imageFrameInfo.image.toByteData(format: ui.ImageByteFormat.png);

    return imageByData!.buffer.asUint8List();
  }

  void initMarkers() async {
    var customIconMarker = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      'assets/Images/marker_icon.png',
    );

    for (var element in places) {
      var myMarkers = Marker(
        icon: customIconMarker,
        markerId: MarkerId(
          element.id.toString(),
        ),
        position: element.latLng,
        infoWindow: InfoWindow(title: element.name),
      );

      setState(() {
        markers.add(myMarkers);
      });
    }
  }

  void initPolyLines() {
    Polyline polyline1 = const Polyline(
      width: 5,
      zIndex: 2,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      polylineId: PolylineId('1'),
      color: Colors.red,
      points: [
        LatLng(30.150815650326667, 30.938221807307883),
        LatLng(30.388027952493566, 30.317494235183418),
        LatLng(30.922007273442244, 30.92174231424263),
        LatLng(31.279478253023033, 30.191151455016488),
      ],
    );

    Polyline polyline2 = const Polyline(
      geodesic: true,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      zIndex: 1,
      polylineId: PolylineId('2'), // Changed PolylineId to '2'
      color: Colors.green,
      points: [
        LatLng(-30.300823371527077, 19.59483773765754),
        LatLng(83.97272072154651, 34.36046335559447),
      ],
    );

    setState(() {
      polyLines.add(polyline1);
      polyLines.add(polyline2);
    });
  }

  void initPolygons() {
    Polygon polygon = Polygon(
      holes: const [
        [
          LatLng(24.551789693433104, 20.093958669925172),
          LatLng(28.328240469162584, 4.800989105371999),
          LatLng(21.150776979029903, 14.468958370319404),
        ],
      ],
      strokeWidth: 5,
      strokeColor: Colors.red,
      fillColor: Colors.black.withOpacity(0.5),
      points: const [
        LatLng(25.267835493359264, 29.965932470739006),
        LatLng(31.45049212140474, -2.7293817707195123),
        LatLng(9.56098013201518, 3.2471810476116163),
        LatLng(25.267835493359264, 29.965932470739006),
      ],
      polygonId: const PolygonId('1'),
    );

    setState(() {
      polygons.add(polygon);
    });
  }

  void initCircles() {
    Circle circle = Circle(
      fillColor: Colors.black.withOpacity(0.5),
      strokeColor: Colors.red,
      circleId: const CircleId('1'),
      center: const LatLng(
        43.877836302467664,
        11.747095564623224,
      ),
      radius: 10000,
    );

    setState(() {
      circles.add(circle);
    });
  }

  Future<void> checkAndRequestLocationService() async {
    var isServiceEnabled = await location.serviceEnabled();
    if (!isServiceEnabled) {
      isServiceEnabled = await location.requestService();

      if (!isServiceEnabled) {
        customShowSnackBar(
          context: context,
          content:
              'Location service is disabled. Please enable it to continue.',
        );
      }
    }
    checkAndRequestLocationPermission();
  }

  Future<bool> checkAndRequestLocationPermission() async {
    var permissionStatus = await location.hasPermission();

    if (permissionStatus == PermissionStatus.deniedForever) {
      return false;
    }

    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      if (permissionStatus != PermissionStatus.granted) {
        return false;
      }
    }

    return true;
  }

  void getLocationData() {
    location.onLocationChanged.listen((locationData) {});
  }

  void updateMyLocation() async {
    await checkAndRequestLocationService();

    var hasPermission = await checkAndRequestLocationPermission();
    if (hasPermission) {
      getLocationData();
    } else {
      customShowSnackBar(
          context: context,
          content: 'Location permission is required to update your location.');
    }
  }
}



// To Get Location

// 1- inquire about location service
// 2- request permission
// 3- get location
// 4- display location