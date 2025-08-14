import 'package:flutter/cupertino.dart';
import 'package:weatherapp/views/login_screen.dart';
import 'package:weatherapp/views/weather_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String weather= '/weather';

  static Map<String, WidgetBuilder> routes ={
    '/weather': (context) => const WeatherScreen(),
    '/login': (context) => const LoginScreen()
  };
}