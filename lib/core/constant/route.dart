import 'package:animevn/feature/home/presentation/view/home_screen.dart';
import 'package:animevn/feature/movie/presentation/view/movie_screen.dart';
import 'package:animevn/feature/search/presentation/view/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:animevn/model/movie.dart';
import 'package:animevn/feature/video_play/presentation/view/videoplayer_screen.dart';



class AppRouteObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    _printRoute('PUSH', route);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    _printRoute('POP', previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    _printRoute('REPLACE', newRoute);
  }

  void _printRoute(String action, Route? route) {
    if (route?.settings.name != null) {
      debugPrint('🧭 [$action] → ${route!.settings.name}');
    } else {
      debugPrint('🧭 [$action] → ${route.runtimeType}');
    }
  }
}


class AppRoutes{
  static const movie = '/movie';
  static const search = '/search';
  static const home = '/home';
  static const videoPlayer = '/videoPlayer';

  AppRoutes._();
}



class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.movie:
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
      case AppRoutes.videoPlayer:
        final Movie data = settings.arguments as Movie;
        return MaterialPageRoute(
            builder: (_) => VideoplayerScreen(movie: data));
      case AppRoutes.search:
        return MaterialPageRoute(builder: (_) => const SearchScreen());
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }
}
