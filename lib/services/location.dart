import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Location {
  double? latitude;
  double? longitude;
  Future<void> getCurrentLocation() async {
    try {
     // LocationPermission permission = await Geolocator.requestPermission();
    //  await Geolocator.openAppSettings();
 //    await Geolocator.openLocationSettings(); 
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
          
      
     
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print(e);
    }
  }
}
