// import 'package:location/location.dart';

// class LocationService {
//   Location location = Location();

//   Future<bool> checkAndRequestLocationService() async {
//     var isServiceEnabled = await location.serviceEnabled();
//     if (!isServiceEnabled) {
//       isServiceEnabled = await location.requestService();

//       if (!isServiceEnabled) {
//         return false;
//         // customShowSnackBar(
//         //   context: context,
//         //   content:
//         //       'Location service is disabled. Please enable it to continue.',
//         // );
//       }
//     }

//     return true;
//   }

//   Future<bool> checkAndRequestLocationPermission() async {
//     var permissionStatus = await location.hasPermission();

//     if (permissionStatus == PermissionStatus.deniedForever) {
//       return false;
//     }

//     if (permissionStatus == PermissionStatus.denied) {
//       permissionStatus = await location.requestPermission();
//       // if (permissionStatus != PermissionStatus.granted) {
//       //   return false;
//       // } else {
//       //   return true;
//       // }

//       // Another Solution

//       return permissionStatus == PermissionStatus.granted;
//     }

//     return true;
//   }

//   void getRealTimeLocationData(void Function(LocationData) onData) {
//     location.onLocationChanged.listen((locationData) {
//       if (locationData != null) {
//         onData(locationData);
//       }
//     });
//   }
// }

import 'package:location/location.dart';

class LocationService {
  Location location = Location();

  Future<bool> checkAndRequestLocationService() async {
    var isServiceEnabled = await location.serviceEnabled();
    if (!isServiceEnabled) {
      isServiceEnabled = await location.requestService();
      if (!isServiceEnabled) {
        return false;
      }
    }

    return true;
  }

  Future<bool> checkAndRequestLocationPermission() async {
    var permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.deniedForever) {
      return false;
    }
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      return permissionStatus == PermissionStatus.granted;
    }

    return true;
  }

  void getRealTimeLocationData(void Function(LocationData)? onData) {
    location.onLocationChanged.listen(onData);
  }
}
