import 'package:animevn/core/bloc/movie/movie_event.dart';
import 'package:animevn/core/bloc/movie/movie_state.dart';
import 'package:animevn/model/apirespone.dart';
import 'package:animevn/shared/service/movie_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc() : super(MovieInitial()) {

    on<UploadCurrentPage>((event, emit) async {
      emit(MovieLoading());
      String link =
          'https://phimapi.com/danh-sach/phim-moi-cap-nhat?page=${event.page}';
      try {
        List<ApiResponse> api = await MovieService.fetchApiWithPage(link);
        emit(ApiLoaded(api));
        print('da cap nhap');
      } catch (e) {
        emit(MovieError('Failed to load : ${e.toString()}'));
      }
    });

    on<LoadApiResponse>((event, emit) async {
      emit(MovieLoading());
      try {
        List<ApiResponse> api = await MovieService.fetchApi(event.url);
        emit(ApiLoaded(api));
      } catch (e) {
        emit(MovieError('Failed to load : ${e.toString()}'));
      }
    });

    on<SearchMovies>((event, emit) async {
      emit(MovieLoading());
      try {
        List<ApiResponse> api = await MovieService.fetchSearch(event.words);
        emit(ApiLoaded(api));
      } catch (e) {
        emit(MovieError('Failed to load : ${e.toString()}'));
      }
    });

    on<LoadApiResponseWithPage>((event, emit) async {
      emit(MovieLoading());
      try {
        List<ApiResponse> api = await MovieService.fetchApiWithPage(event.url);
        emit(ApiLoaded(api));
      } catch (e) {
        emit(MovieError('Failed to load : ${e.toString()}'));
      }
    });
  }
}
