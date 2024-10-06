// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:google_maps_flutter/google_maps_flutter.dart';
// // import 'dart:ui' as ui;

// // import 'package:live_location_tracker/models/place_model.dart';

// // class CustomGoogleMaps extends StatefulWidget {
// //   const CustomGoogleMaps({super.key});

// //   @override
// //   State<CustomGoogleMaps> createState() => _CustomGoogleMapsState();
// // }

// // class _CustomGoogleMapsState extends State<CustomGoogleMaps> {
// //   late CameraPosition initialCameraPosition;

// //   @override
// //   void initState() {
// //     initialCameraPosition = CameraPosition(
// //         target: LatLng(30.29773520757277, 31.301290699998926), zoom: 3);

// //     initMarkers();
// //     initPolyLines();
// //     initPolygons();
// //     initCircles();
// //     super.initState();
// //   }

// //   late GoogleMapController googleMapController;

// //   Set<Marker> markers = {};
// //   Set<Polyline> polyLines = {};
// //   Set<Polygon> polygons = {};
// //   Set<Circle> circles = {};

// //   @override
// //   Widget build(BuildContext context) {
// //     return Stack(
// //       children: [
// //         GoogleMap(
// //             polygons: polygons,
// //             polylines: polyLines,
// //             circles: circles,
// //             markers: markers,
// //             //mapType: MapType.hybrid,
// //             zoomControlsEnabled: true,
// //             onMapCreated: (controller) {
// //               googleMapController =
// //                   controller; // googleMapController Initialized

// //               initialMapStyle();
// //             },

// //             // cameraTargetBounds: CameraTargetBounds(
// //             //   LatLngBounds(
// //             //       northeast: LatLng(31.59413973234032, 34.00088191420149),
// //             //       southwest: LatLng(30.80477178508606, 28.485744901697405)),
// //             // ),
// //             initialCameraPosition: initialCameraPosition),
// //         Positioned(
// //           bottom: 16,
// //           right: 16,
// //           left: 16,
// //           child: ElevatedButton(
// //             onPressed: () {
// //               //print('Changing Location');
// //               // CameraPosition newLocation = CameraPosition(
// //               //   target: LatLng(16.76948812513405, 48.799466686797125),
// //               // );

// //               LatLng latLng = LatLng(16.76948812513405, 48.799466686797125);

// //               googleMapController.animateCamera(
// //                 CameraUpdate.newLatLng(latLng),
// //               );
// //             },
// //             child: const Padding(
// //               padding: EdgeInsets.all(8.0),
// //               child: Text(
// //                 'Change Location',
// //                 style: TextStyle(fontSize: 20),
// //               ),
// //             ),
// //           ),
// //         )
// //       ],
// //     );
// //   }

// //   void initialMapStyle() async {
// //     var nightStyle = await DefaultAssetBundle.of(context)
// //         .loadString('assets/google_map_styles/night_style.json');

// //     // var retroStyle = await DefaultAssetBundle.of(context)
// //     //     .loadString('assets/google_map_styles/retro.json');

// //     googleMapController.setMapStyle(nightStyle);
// //   }

// //   Future<Uint8List> getImageFromRowData(String image, double width) async {
// //     var imageData = await rootBundle.load(image);

// //     // إنشاء رمز الصورة باستخدام البيانات المحملة وتحديد العرض المطلوب
// //     var imageCodec = await ui.instantiateImageCodec(
// //       imageData.buffer.asUint8List(),
// //       targetWidth: width.round(),
// //     );

// //     // الحصول على الإطار الأول من رمز الصورة
// //     var imageFrameInfo = await imageCodec.getNextFrame();

// //     // تحويل الصورة إلى بيانات ثنائية باستخدام صيغة PNG
// //     var imageByData =
// //         await imageFrameInfo.image.toByteData(format: ui.ImageByteFormat.png);

// //     // التحقق من أن عملية التحويل نجحت قبل الوصول إلى البيانات

// //     return imageByData!.buffer.asUint8List();
// //   }

// //   void initMarkers() async {
// //     // var myMarker = const Marker(
// //     //   markerId: MarkerId('1'),
// //     //   position: LatLng(30.29773520757277, 31.301290699998926),
// //     // );
// //     // var myMarker2 = const Marker(
// //     //   markerId: MarkerId('1'),
// //     //   position: LatLng(28.29773520757277, 31.301290699998926),
// //     // );

// //     // markers.add(myMarker);
// //     // markers.add(myMarker2);

// //     // var MyMarkers = places
// //     //     .map(
// //     //       (place_model) => Marker(
// //     //           markerId: MarkerId(
// //     //             place_model.id.toString(),
// //     //           ),
// //     //           position: place_model.latLng),
// //     //     )
// //     //     .toSet();

// //     // var custonIconMarker = BitmapDescriptor.fromBytes(
// //     //     await getImageFromRowData('assets/Images/marker_icon.png', 200));

// //     // if there are image with required size ==> upload image and use it

// //     var customIconMarker = await BitmapDescriptor.asset(
// //         ImageConfiguration(), 'assets/Images/marker_icon.png');
// //     // Another Solution Using For In
// //     for (var element in places) {
// //       var MyMarkers = Marker(
// //         icon: customIconMarker,
// //         markerId: MarkerId(
// //           element.id.toString(),
// //         ),
// //         position: element.latLng,
// //         infoWindow: InfoWindow(title: element.name),
// //       );

// //       setState(() {
// //         markers.add(MyMarkers);
// //       });
// //     }
// //   }

// //   void initPolyLines() {
// //     Polyline polyline1 = const Polyline(
// //         width: 5,
// //         //geodesic: true,
// //         zIndex: 2, // the second line created
// //         startCap: Cap.roundCap,
// //         endCap: Cap.roundCap,
// //         polylineId: PolylineId('1'),
// //         color: Colors.red,
// //         points: [
// //           LatLng(30.150815650326667, 30.938221807307883),
// //           LatLng(30.388027952493566, 30.317494235183418),
// //           LatLng(30.922007273442244, 30.92174231424263),
// //           LatLng(31.279478253023033, 30.191151455016488)
// //         ]);

// //     Polyline polyline2 = const Polyline(
// //         geodesic: true,
// //         startCap: Cap.roundCap,
// //         endCap: Cap.roundCap,
// //         zIndex: 1, // the first line created
// //         polylineId: PolylineId('1'),
// //         color: Colors.green,
// //         points: [
// //           LatLng(-30.300823371527077, 19.59483773765754),
// //           LatLng(83.97272072154651, 34.36046335559447),
// //         ]);

// //     polyLines.add(polyline1);
// //     polyLines.add(polyline2);
// //   }

// //   void initPolygons() {
// //     Polygon polygon = Polygon(
// //       holes: [
// //         [
// //           LatLng(24.551789693433104, 20.093958669925172),
// //           LatLng(28.328240469162584, 4.800989105371999),
// //           LatLng(21.150776979029903, 14.468958370319404),
// //         ],
// //       ],
// //       strokeWidth: 5,
// //       strokeColor: Colors.red,
// //       fillColor: Colors.black.withOpacity(0.5),
// //       points: const [
// //         LatLng(25.267835493359264, 29.965932470739006),
// //         LatLng(31.45049212140474, -2.7293817707195123),
// //         LatLng(9.56098013201518, 3.2471810476116163),
// //         LatLng(25.267835493359264, 29.965932470739006)
// //       ],
// //       polygonId: const PolygonId('1'),
// //     );

// //     polygons.add(polygon);
// //   }

// //   void initCircles() {
// //     Circle circle = Circle(
// //       fillColor: Colors.black.withOpacity(0.5),
// //       strokeColor: Colors.red,
// //       circleId: CircleId('1'),
// //       center: LatLng(43.877836302467664, 11.747095564623224),
// //       radius: 10000,
// //     );

// //     circles.add(circle);
// //   }
// // }

// // // Zoom numbers in Google Maps
// // // World View : 0 ==> 3
// // // Country View : 4 ==> 6
// // // City View : 10 ==> 12
// // // Street View : 13 ==> 17
// // // building View : 18 ==> 20

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'dart:ui' as ui;

// import 'package:live_location_tracker/models/place_model.dart';

// class CustomGoogleMaps extends StatefulWidget {
//   const CustomGoogleMaps({super.key});

//   @override
//   State<CustomGoogleMaps> createState() => _CustomGoogleMapsState();
// }

// class _CustomGoogleMapsState extends State<CustomGoogleMaps> {
//   late CameraPosition initialCameraPosition;
//   GoogleMapController? googleMapController;

//   @override
//   void initState() {
//     initialCameraPosition = CameraPosition(
//         target: LatLng(30.29773520757277, 31.301290699998926), zoom: 3);

//     initMarkers();
//     initPolyLines();
//     initPolygons();
//     initCircles();
//     super.initState();
//   }

//   Set<Marker> markers = {};
//   Set<Polyline> polyLines = {};
//   Set<Polygon> polygons = {};
//   Set<Circle> circles = {};

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         GoogleMap(
//             polygons: polygons,
//             polylines: polyLines,
//             circles: circles,
//             markers: markers,
//             zoomControlsEnabled: true,
//             onMapCreated: (controller) {
//               googleMapController =
//                   controller; // googleMapController Initialized

//               initialMapStyle();
//             },
//             initialCameraPosition: initialCameraPosition),
//         Positioned(
//           bottom: 16,
//           right: 16,
//           left: 16,
//           child: ElevatedButton(
//             onPressed: () {
//               if (googleMapController != null) {
//                 LatLng latLng = LatLng(16.76948812513405, 48.799466686797125);

//                 googleMapController!.animateCamera(
//                   CameraUpdate.newLatLng(latLng),
//                 );
//               }
//             },
//             child: const Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Text(
//                 'Change Location',
//                 style: TextStyle(fontSize: 20),
//               ),
//             ),
//           ),
//         )
//       ],
//     );
//   }

//   void initialMapStyle() async {
//     var nightStyle = await DefaultAssetBundle.of(context)
//         .loadString('assets/google_map_styles/night_style.json');

//     if (googleMapController != null) {
//       googleMapController!.setMapStyle(nightStyle);
//     }
//   }

//   Future<Uint8List> getImageFromRowData(String image, double width) async {
//     var imageData = await rootBundle.load(image);

//     var imageCodec = await ui.instantiateImageCodec(
//       imageData.buffer.asUint8List(),
//       targetWidth: width.round(),
//     );

//     var imageFrameInfo = await imageCodec.getNextFrame();

//     var imageByData =
//         await imageFrameInfo.image.toByteData(format: ui.ImageByteFormat.png);

//     return imageByData!.buffer.asUint8List();
//   }

//   void initMarkers() async {
//     var customIconMarker = await BitmapDescriptor.fromAssetImage(
//         ImageConfiguration(), 'assets/Images/marker_icon.png');

//     for (var element in places) {
//       var MyMarkers = Marker(
//         icon: customIconMarker,
//         markerId: MarkerId(
//           element.id.toString(),
//         ),
//         position: element.latLng,
//         infoWindow: InfoWindow(title: element.name),
//       );

//       setState(() {
//         markers.add(MyMarkers);
//       });
//     }
//   }

//   void initPolyLines() {
//     Polyline polyline1 = const Polyline(
//         width: 5,
//         zIndex: 2,
//         startCap: Cap.roundCap,
//         endCap: Cap.roundCap,
//         polylineId: PolylineId('1'),
//         color: Colors.red,
//         points: [
//           LatLng(30.150815650326667, 30.938221807307883),
//           LatLng(30.388027952493566, 30.317494235183418),
//           LatLng(30.922007273442244, 30.92174231424263),
//           LatLng(31.279478253023033, 30.191151455016488)
//         ]);

//     Polyline polyline2 = const Polyline(
//         geodesic: true,
//         startCap: Cap.roundCap,
//         endCap: Cap.roundCap,
//         zIndex: 1,
//         polylineId: PolylineId('2'), // Changed PolylineId to '2'
//         color: Colors.green,
//         points: [
//           LatLng(-30.300823371527077, 19.59483773765754),
//           LatLng(83.97272072154651, 34.36046335559447),
//         ]);

//     setState(() {
//       polyLines.add(polyline1);
//       polyLines.add(polyline2);
//     });
//   }

//   void initPolygons() {
//     Polygon polygon = Polygon(
//       holes: [
//         [
//           LatLng(24.551789693433104, 20.093958669925172),
//           LatLng(28.328240469162584, 4.800989105371999),
//           LatLng(21.150776979029903, 14.468958370319404),
//         ],
//       ],
//       strokeWidth: 5,
//       strokeColor: Colors.red,
//       fillColor: Colors.black.withOpacity(0.5),
//       points: const [
//         LatLng(25.267835493359264, 29.965932470739006),
//         LatLng(31.45049212140474, -2.7293817707195123),
//         LatLng(9.56098013201518, 3.2471810476116163),
//         LatLng(25.267835493359264, 29.965932470739006)
//       ],
//       polygonId: const PolygonId('1'),
//     );

//     setState(() {
//       polygons.add(polygon);
//     });
//   }

//   void initCircles() {
//     Circle circle = Circle(
//       fillColor: Colors.black.withOpacity(0.5),
//       strokeColor: Colors.red,
//       circleId: CircleId('1'),
//       center: LatLng(43.877836302467664, 11.747095564623224),
//       radius: 10000,
//     );

//     setState(() {
//       circles.add(circle);
//     });
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

import 'package:live_location_tracking_22/models/place_model.dart';

class CustomGoogleMaps extends StatefulWidget {
  const CustomGoogleMaps({super.key});

  @override
  State<CustomGoogleMaps> createState() => _CustomGoogleMapsState();
}

class _CustomGoogleMapsState extends State<CustomGoogleMaps> {
  late CameraPosition initialCameraPosition;
  GoogleMapController? googleMapController;
  bool isMapReady = false;

  @override
  void initState() {
    initialCameraPosition = CameraPosition(
      target: LatLng(30.29773520757277, 31.301290699998926),
      zoom: 3,
    );

    super.initState();
    initMarkers();
    initPolyLines();
    initPolygons();
    initCircles();
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
        .loadString('assets/google_map_styles/night_style.json');

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
      holes: [
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
      circleId: CircleId('1'),
      center: LatLng(43.877836302467664, 11.747095564623224),
      radius: 10000,
    );

    setState(() {
      circles.add(circle);
    });
  }
}
