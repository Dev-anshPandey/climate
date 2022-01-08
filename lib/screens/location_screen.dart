import 'package:clima/screens/city_screen.dart';
import 'package:clima/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

const apikey = 'e6923d33c0f5d5870fa8f3919267e851';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.lweather});

  final lweather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int temperature = 0;
  var condition;
  var Weather;
  var message;
  String? cityName;

  void initState() {
    // print(widget.lweather['weather'][0]['id']);
    uIUpdate(widget.lweather);
  }

  void uIUpdate(dynamic a) {
    setState(() {
      if (a == null) {
        temperature = 0;
        condition = "";
        cityName = "";
        Weather = "Error";
        message = "Unabe to get weather data";

        return;
      }
      double temperatur = a['main']['temp'];
      temperature = temperatur.toInt();
      condition = a['weather'][0]['id'];
      cityName = a['name'];
      WeatherModel weather = WeatherModel();
      Weather = weather.getWeatherIcon(condition);
      message = weather.getMessage(temperature);
    });
  }

  @override
  Widget build(BuildContext context) {
    WeatherModel weather = WeatherModel();
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      LocationPermission permission =
                          await Geolocator.checkPermission();

                      // LocationPermission permission = await Geolocator.requestPermission();
                      await Geolocator.openAppSettings();
                      //  await Geolocator.openLocationSettings();

                      dynamic wd = await weather.getWeather();
                      uIUpdate(wd);
                    },
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var cityy =  await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CityScreen()));
                      if (cityy !=  null) {
                        print(cityy);
                        var weathers = await weather.city(cityy);
                        
                        uIUpdate(weathers);
                      }
                    },
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      "$Weather",
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  " $message in $cityName ",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
