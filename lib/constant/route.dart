import 'package:animevn/model/apirespone.dart';
import 'package:animevn/screen/home_screen.dart';
import 'package:animevn/screen/movie/movie_screen.dart';
import 'package:animevn/screen/videoplayer/videoplayer_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case '/movie' :
        final ApiResponse data = settings.arguments as ApiResponse;
        return MaterialPageRoute(builder: (_)=> MovieScreen(data: data));
      case '/videoplayer' :
        final ApiResponse data = settings.arguments as ApiResponse;
        return MaterialPageRoute(builder: (_)=> VideoplayerScreen(apiData: data));
      case '/home' :
        return MaterialPageRoute(builder: (_)=> const HomeScreen());
      default:
        return MaterialPageRoute(builder: (_)=> const HomeScreen());
    }
  }
}