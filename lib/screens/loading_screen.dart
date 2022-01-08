import 'package:flutter/material.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clima/services/weather.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double? Latitude;
  double? longitude;
  @override
  void initState() {
    getLocation();
  }

  void getLocation() async {
    WeatherModel weatherModel = WeatherModel();
    dynamic weather = await weatherModel.getWeather();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        lweather: weather,
      );
    }));
  }

  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitWave(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}
