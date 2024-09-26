import 'dart:convert';

import 'package:animevn/bloc/movie/movie_event.dart';
import 'package:animevn/bloc/movie/movie_state.dart';
import 'package:animevn/model/apirespone.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../model/episode.dart';
import '../../model/movie.dart';


class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc() : super(MovieInitial()) {

   on<LoadApi>((event, emit) async {
     emit(MovieLoading());
     try{
       List<ApiResponse> apies = await fetchApi('https://phimapi.com/danh-sach/phim-moi-cap-nhat?page=1');
       emit(ApiLoaded(apies));
     } catch(e) {
       emit(MovieError('Failed to load : ${e.toString()}'));
     }
   });

   on<LoadApiResponse>((event, emit) async {
     emit(MovieLoading());
     try{
       List<ApiResponse> api = await fetchApi(event.url);
        emit(ApiLoaded(api));
     }catch(e){
       emit(MovieError('Failed to load : ${e.toString()}'));
     }
   });

   on<SearchMovies>((event, emit) async {
     emit(MovieLoading());
     try{
       List<ApiResponse> api = await fetchSearch(event.words);
       emit(ApiLoaded(api));
     }catch(e){
       emit(MovieError('Failed to load : ${e.toString()}'));
     }
   });

   on<LoadApiResponseWithPage>((event, emit) async {
     emit(MovieLoading());
     try{
       List<ApiResponse> api = await fetchApiWithPage(event.url);
       emit(ApiLoaded(api));
     }catch(e){
       emit(MovieError('Failed to load : ${e.toString()}'));
     }
   });

   on<LoadMovieByUrl>((event, emit) async {
     emit(MovieLoading());
     final url =
         'https://phimapi.com/phim/${event.url}';
     try{
       Movie movie = await getMovie(url);
       emit(MovieLoaded(movie));
     }catch(e){
       print(e);
       emit(MovieError('Failed to load : ${e.toString()}'));
     }
   });

  }

  Future<List<ApiResponse>> fetchApi(String link) async{
    final url = link;
    try{
      final reponse = await http.get(Uri.parse(url));
      final jsonData = jsonDecode(reponse.body);
      List<dynamic> items = jsonData['data']['items'];
      List<ApiResponse> data = List<ApiResponse>.from(
          items.map((item) => ApiResponse.fromMap(item))
      );
      return data;
    }catch(e){
      return Future.error(Exception(e));
    }
  }

  Future<List<ApiResponse>> fetchSearch(String words) async{
    String url = 'https://phimapi.com/v1/api/tim-kiem?keyword=$words&limit=10';
    try{
      final reponse = await http.get(Uri.parse(url));
      final jsonData = jsonDecode(reponse.body);
      List<dynamic> items = jsonData['data']['items'];
      List<ApiResponse> data = List<ApiResponse>.from(
          items.map((item) => ApiResponse.fromMap(item))
      );
      print(words);
      return data;
    }catch(e){
      return Future.error(Exception(e));
    }
  }

  Future<List<ApiResponse>> fetchApiWithPage(String link) async {
    final url = link;
    try {
      final response = await http.get(Uri.parse(url));

        final jsonData = jsonDecode(response.body);
        List<dynamic> items = jsonData['items'];
        List<ApiResponse> data = List<ApiResponse>.from(
          items.map((item) => ApiResponse.fromMap(item)),
        );
        return data;
    } catch (e) {
      return Future.error(Exception(e));
    }
  }

  Future<Movie> getMovie(String link) async {
    final url = link;
    try {
      final response = await http.get(Uri.parse(url));
      final jsonData = jsonDecode(response.body);

      // Lấy thông tin phim
      Movie movie = Movie.fromMap(jsonData['movie'] as Map<String, dynamic>);

      // Kiểm tra sự tồn tại của trường episodes
      if (jsonData['episodes'] != null && jsonData['episodes'] is List) {
        List<EpisodeData> episodeDataList = (jsonData['episodes'] as List<dynamic>)
            .expand((e) => (e['server_data'] as List<dynamic> ))
            .map((e) => EpisodeData.fromMap(e as Map<String, dynamic>))
            .toList();

        // Tạo đối tượng Episode và gán vào movie
        Episode episode = Episode(
          serverName: jsonData['episodes'][0]['server_name'] ?? '',
          serverData: episodeDataList,
        );
        movie.episodes = episode;
        movie.episodes.serverData = episodeDataList;
      } else {
        // Nếu không có episodes, gán giá trị mặc định
        movie.episodes = Episode(serverName: '', serverData: []);
      }

      return movie;
    } catch (e) {
      return Future.error(Exception(e));
    }
  }

}


