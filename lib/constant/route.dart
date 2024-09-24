import 'package:animevn/screen/home_screen.dart';
import 'package:animevn/screen/movie/movie_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/movie.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case '/movie' :
        final Movie movie = settings.arguments as Movie;
        return MaterialPageRoute(builder: (_)=> MovieScreen(movie: movie));
      case '/home' :
        return MaterialPageRoute(builder: (_)=> const HomeScreen());
      default:
        return MaterialPageRoute(builder: (_)=> const HomeScreen());
    }
  }
}