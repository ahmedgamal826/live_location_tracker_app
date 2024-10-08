import 'package:flutter/material.dart';
import 'package:live_location_tracking_22/widgets/custom_google_maps.dart';

void main() {
  runApp(const LiveLocationTrackerApp());
}

class LiveLocationTrackerApp extends StatelessWidget {
  const LiveLocationTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CustomGoogleMap(),
    );
  }
}
