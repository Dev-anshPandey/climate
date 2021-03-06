import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const apikey = 'e6923d33c0f5d5870fa8f3919267e851';

class WeatherModel {
  Future<dynamic> getWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
    Network network = Network(
        'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apikey&units=metric');
    dynamic weather = await network.getData();

    return weather;
  }

  Future<dynamic> city(cityN) async {
   // print(cityN);
    Network network = Network(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityN&appid=$apikey&units=metric');

  //  print(network);
    dynamic weather = await network.getData();
    return weather;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '๐ฉ';
    } else if (condition < 400) {
      return '๐ง';
    } else if (condition < 600) {
      return 'โ๏ธ';
    } else if (condition < 700) {
      return 'โ๏ธ';
    } else if (condition < 800) {
      return '๐ซ';
    } else if (condition == 800) {
      return 'โ๏ธ';
    } else if (condition <= 804) {
      return 'โ๏ธ';
    } else {
      return '๐คทโ';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s ๐ฆ time';
    } else if (temp > 20) {
      return 'Time for shorts and ๐';
    } else if (temp < 10) {
      return 'You\'ll need ๐งฃ and ๐งค';
    } else {
      return 'Bring a ๐งฅ just in case';
    }
  }
}
