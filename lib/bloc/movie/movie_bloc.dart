import 'dart:convert';

import 'package:animevn/bloc/movie/movie_event.dart';
import 'package:animevn/bloc/movie/movie_state.dart';
import 'package:animevn/model/apirespone.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';

import '../../model/episode.dart';
import '../../model/movie.dart';


class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc() : super(MovieInitial()) {

    on<UploadCurrentPage>((event, emit) async {
      emit(MovieLoading());
      String link = 'https://phimapi.com/danh-sach/phim-moi-cap-nhat?page=${event.page}';
      try{
        List<ApiResponse> api = await fetchApiWithPage(link);
        emit(ApiLoaded(api));
        print('da cap nhap');
      }catch(e){
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

  // Lưu dữ liệu vào cache
  Future<void> cacheUrl(String url, Map<String, dynamic> jsonData) async {
    final cacheManager = DefaultCacheManager();
    final jsonString = jsonEncode(jsonData); // Mã hóa JSON thành chuỗi
    final byteData = utf8.encode(jsonString); // Chuyển đổi chuỗi thành List<int>
    final uint8ListData = Uint8List.fromList(byteData); // Chuyển List<int> thành Uint8List
    await cacheManager.putFile(url, uint8ListData); // Lưu vào cache
  }

  Future<List<ApiResponse>> fetchApi(String link) async {
    final url = link;
    final cacheManager = DefaultCacheManager();

    // Kiểm tra dữ liệu trong cache trước
    final fileInfo = await cacheManager.getFileFromCache(url);
    if (fileInfo != null) {
      final jsonString = await fileInfo.file.readAsString();
      List<dynamic> items = jsonDecode(jsonString)['data']['items'];
      return List<ApiResponse>.from(
        items.map((item) => ApiResponse.fromMap(item)),
      );
    }

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode != 200) {
        throw Exception('Failed to load data: ${response.statusCode}');
      }

      final jsonData = jsonDecode(response.body);
      await cacheUrl(url, jsonData);

      List<dynamic> items = jsonData['data']['items'];
      List<ApiResponse> data = List<ApiResponse>.from(
        items.map((item) => ApiResponse.fromMap(item)),
      );

      return data;
    } catch (e) {
      return Future.error(Exception(e));
    }
  }

  Future<List<ApiResponse>> fetchApiWithPage(String link) async {
    final url = link;
    final cacheManager = DefaultCacheManager();

    // Kiểm tra dữ liệu trong cache trước
    final fileInfo = await cacheManager.getFileFromCache(url);
    if (fileInfo != null) {
      final jsonString = await fileInfo.file.readAsString();
      List<dynamic> items = jsonDecode(jsonString)['items'];
      return List<ApiResponse>.from(
        items.map((item) => ApiResponse.fromMap(item)),
      );
    }

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode != 200) {
        throw Exception('Failed to load data: ${response.statusCode}');
      }

      final jsonData = jsonDecode(response.body);
      await cacheUrl(url, jsonData);

      List<dynamic> items = jsonData['items'];
      List<ApiResponse> data = List<ApiResponse>.from(
        items.map((item) => ApiResponse.fromMap(item)),
      );
      return data;
    } catch (e) {
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



  Future<Movie> getMovie(String link) async {
    final url = link;
    try {
      final response = await http.get(Uri.parse(url));
      final jsonData = jsonDecode(response.body);

      Movie movie = Movie.fromMap(jsonData['movie'] as Map<String, dynamic>);


      if (jsonData['episodes'] != null && jsonData['episodes'] is List) {
        List<EpisodeData> episodeDataList = (jsonData['episodes'] as List<dynamic>)
            .expand((e) => (e['server_data'] as List<dynamic> ))
            .map((e) => EpisodeData.fromMap(e as Map<String, dynamic>))
            .toList();

        Episode episode = Episode(
          serverName: jsonData['episodes'][0]['server_name'] ?? '',
          serverData: episodeDataList,
        );
        movie.episodes = episode;
        movie.episodes.serverData = episodeDataList;
      } else {
        movie.episodes = Episode(serverName: '', serverData: []);
      }

      return movie;
    } catch (e) {
      return Future.error(Exception(e));
    }
  }

}


