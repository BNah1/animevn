import 'package:animevn/feature/home/presentation/view/home_screen.dart';
import 'package:animevn/feature/movie/presentation/view/movie_screen.dart';
import 'package:flutter/material.dart';

import '../../model/movie.dart';
import '../../feature/video_play/presentation/view/videoplayer_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MovieScreen.routerName:
        final args = settings.arguments as Map<String, dynamic>;
        final String slug = args['slug'];
        final String pathImage = args['pathImage'];
        final String heroTag = args['heroTag'];

        return PageRouteBuilder(
          transitionDuration: const Duration(seconds: 1),
          // reverseTransitionDuration: const Duration(milliseconds: 600),
          pageBuilder: (context, animation, secondaryAnimation) {
            return MovieScreen(linkMovie: slug, pathImage: pathImage, heroTag: heroTag,);
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );

      // return MaterialPageRoute(
      //   builder: (_) => MovieScreen(linkMovie: slug, pathImage: pathImage,),
      // );
      case '/videoplayer':
        final Movie data = settings.arguments as Movie;
        return MaterialPageRoute(
            builder: (_) => VideoplayerScreen(movie: data));
      // case '/search':
      //   return MaterialPageRoute(builder: (_) => const SearchScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }
}
