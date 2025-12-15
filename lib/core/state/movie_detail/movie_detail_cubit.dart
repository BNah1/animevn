import 'package:animevn/core/state/base_cubit.dart';
import 'package:animevn/core/state/base_state.dart';
import 'package:animevn/model/movie.dart';
import 'package:animevn/shared/service/movie_service.dart';


class MovieDetailState extends BaseState{
  final Movie? movie;
  MovieDetailState({super.status, super.errorMessage, this.movie});


  @override
  BaseState copyWith({BaseStatus? status, String? errorMessage, Movie? movie}) {
    return MovieDetailState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      movie: movie ?? this.movie,
    );
  }
}


class MovieDetailCubit extends BaseCubit<MovieDetailState>{
  final String url;

  MovieDetailCubit(this.url)
      : super(MovieDetailState(movie: null)){
    init();
  }

  Future<void> init()async {
    setLoading();
    final link =
        'https://phimapi.com/phim/$url';
    try{
      Movie movie = await MovieService.getMovie(link);
      final result = state.copyWith(movie: movie);
      setLoaded(result);
    }catch(e){
      setError('Failed to load : ${e.toString()}');
    }
  }

}