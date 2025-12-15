import 'dart:convert';

import 'package:animevn/model/apirespone.dart';
import 'package:animevn/model/episode.dart';
import 'package:animevn/model/movie.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;

import 'cache_service.dart';

class MovieService{

  static Future<Movie> getMovie(String link) async {
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


  static Future<List<ApiResponse>> fetchApi(String link) async {
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
      await CacheService.cacheUrl(url, jsonData);

      List<dynamic> items = jsonData['data']['items'];
      List<ApiResponse> data = List<ApiResponse>.from(
        items.map((item) => ApiResponse.fromMap(item)),
      );

      return data;
    } catch (e) {
      return Future.error(Exception(e));
    }
  }

  static Future<List<ApiResponse>> fetchApiWithPage(String link) async {
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
      await CacheService.cacheUrl(url, jsonData);

      List<dynamic> items = jsonData['items'];
      List<ApiResponse> data = List<ApiResponse>.from(
        items.map((item) => ApiResponse.fromMap(item)),
      );
      return data;
    } catch (e) {
      return Future.error(Exception(e));
    }
  }

  static Future<List<ApiResponse>> fetchSearch(String words) async{
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

  MovieService._();
}
