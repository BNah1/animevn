import 'package:animevn/screen/home_screen.dart';
import 'package:animevn/screen/movie/movie_screen.dart';
import 'package:animevn/screen/search_screen.dart';
import 'package:flutter/material.dart';

import '../model/movie.dart';
import '../screen/videoplayer/videoplayer_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case '/movie' :
        final String data = settings.arguments as String;
        return MaterialPageRoute(builder: (_)=> MovieScreen(linkMovie: data));
      case '/videoplayer' :
        final Movie data = settings.arguments as Movie;
        return MaterialPageRoute(builder: (_)=> VideoplayerScreen(movie: data));
      case '/search' :
        return MaterialPageRoute(builder: (_)=> const SearchScreen());
      case '/home' :
        return MaterialPageRoute(builder: (_)=> const HomeScreen());
      default:
        return MaterialPageRoute(builder: (_)=> const HomeScreen());
    }
  }
}