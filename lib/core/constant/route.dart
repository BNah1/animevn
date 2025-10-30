import 'package:animevn/core/bloc/movie/movie_bloc.dart';
import 'package:animevn/feature/home/presentation/view/home_screen.dart';
import 'package:animevn/feature/movie/presentation/view/movie_screen.dart';
import 'package:animevn/feature/search/presentation/view/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/movie.dart';
import '../../feature/video_play/presentation/view/videoplayer_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/movie':
        final args = settings.arguments as Map<String, dynamic>;
        final String slug = args['slug'];
        final MovieBloc bloc = args['bloc'];
        final String pathImage = args['pathImage'];

        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: bloc,
            child: MovieScreen(linkMovie: slug, pathImage: pathImage,),
          ),
        );
      case '/videoplayer':
        final Movie data = settings.arguments as Movie;
        return MaterialPageRoute(
            builder: (_) => VideoplayerScreen(movie: data));
      case '/search':
        return MaterialPageRoute(builder: (_) => const SearchScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }
}
