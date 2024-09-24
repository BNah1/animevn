import 'package:flutter/material.dart';

import '../model/category.dart';
import '../model/movie.dart';
import '../model/movie/country.dart';
import '../model/poster.dart';

class Constants {
  // Default padding for screens
  static const defaultPadding = EdgeInsets.symmetric(
    horizontal: 15,
    vertical: 10,
  );

  // demo profile urls
  static const String testImage =
      'https://images.unsplash.com/photo-1517404215738-15263e9f9178?q=80&w=4114&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';

  static const String maleProfilePic =
      'https://jeremyveldman.com/wp-content/uploads/2019/08/Generic-Profile-Pic.jpg';

  static const String profilePicBlank =
      'https://t3.ftcdn.net/jpg/05/16/27/58/240_F_516275801_f3Fsp17x6HQK0xQgDQEELoTuERO4SsWV.jpg';

  static const String testVideoUrl = 'https://s2.phim1280.tv/20230907/S7BVCpM0/index.m3u8';

  static List<Tab> getHomeScreenTabs(int index) {
    return [
      Tab(
        icon: Icon(
          index == 0 ? Icons.home : Icons.home_outlined,
          color: Colors.blue,
        ),
      ),
      Tab(
        icon: Icon(
          index == 1 ? Icons.group : Icons.group_outlined,
          color: Colors.blue,
        ),
      ),
      Tab(
        icon: Icon(
          index == 2 ? Icons.smart_display : Icons.smart_display_outlined,
          color: Colors.blue,
        ),
      ),
      Tab(
        icon: Icon(
          index == 3 ? Icons.account_circle : Icons.account_circle_outlined,
          color: Colors.blue,
        ),
      ),
    ];
  }
  static  Category action = Category(id: '1', name: 'Action');
  static  Category drama = Category(id: '2', name: 'Drama');
  static  Country usa = Country(id: '1', name: 'USA', slug: '');
  static  Country uk = Country(id: '2', name: 'UK', slug: '');
  static  Country japan = Country(id: '3', name: 'Japan', slug: '');


  static List<Movie> movieList = [
    Movie(
      id: '1',
      name: 'Movie 1',
      originName: 'Phim 1',
      content: 'Nội dung phim 1',
      type: 'Hành động',
      status: 'Đang chiếu',
      posterUrl: 'https://phimimg.com//upload//vod//20240920-1//9087ee5150f26bac9ae48793befc6c10.jpg',
      thumbUrl: Constants.testImage,
      time: '120 phút',
      episodeCurrent: '1',
      episodeTotal: '10',
      quality: 'HD',
      lang: 'Vietnamese',
      actor: ['Actor 1', 'Actor 2'],
      director: ['Director 1'],
      categories: [action],
      countries: [usa],
      year: '2023',
    ),
    Movie(
      id: '2',
      name: 'Movie 2',
      originName: 'Phim 2',
      content: 'Nội dung phim 2',
      type: 'Hài',
      status: 'Đang chiếu',
      posterUrl: 'https://phimimg.com//upload//vod//20240920-1//265683de955921873753f8802a78ba67.jpg',
      thumbUrl: Constants.testImage,
      time: '100 phút',
      episodeCurrent: '1',
      episodeTotal: '5',
      quality: 'HD',
      lang: 'Vietnamese',
      actor: ['Actor 3', 'Actor 4'],
      director: ['Director 2'],
      categories: [drama],
      countries: [usa],
      year: '2023',
    ),
    Movie(
      id: '3',
      name: 'Movie 3',
      originName: 'Phim 3',
      content: 'Nội dung phim 3',
      type: 'Kinh dị',
      status: 'Sắp chiếu',
      posterUrl: 'https://phimimg.com//upload//vod//20240920-1//649b3d26d7f469eddba585430bdf9fb5.jpg',
      thumbUrl: Constants.testImage,
      time: '90 phút',
      episodeCurrent: '1',
      episodeTotal: '8',
      quality: 'HD',
      lang: 'Vietnamese',
      actor: ['Actor 5', 'Actor 6'],
      director: ['Director 3'],
      categories: [],
      countries: [uk],
      year: '2023',
    ),
    Movie(
      id: '4',
      name: 'Movie 4',
      originName: 'Phim 4',
      content: 'Nội dung phim 4',
      type: 'Phiêu lưu',
      status: 'Đang chiếu',
      posterUrl: 'https://phimimg.com//upload//vod//20231029-1//134b92a92d78f905d7c60f92a8b03846.jpg',
      thumbUrl: Constants.testImage,
      time: '110 phút',
      episodeCurrent: '1',
      episodeTotal: '6',
      quality: 'HD',
      lang: 'Vietnamese',
      actor: ['Actor 7', 'Actor 8'],
      director: ['Director 4'],
      categories: [],
      countries: [japan],
      year: '2023',
    ),
    Movie(
      id: '5',
      name: 'Movie 5',
      originName: 'Phim 5',
      content: 'Nội dung phim 5',
      type: 'Phiêu lưu',
      status: 'Đang chiếu',
      posterUrl: 'https://phimimg.com//upload//vod//20230929-1//a6110983f8de490e116383020adc4662.jpg',
      thumbUrl: Constants.testImage,
      time: '110 phút',
      episodeCurrent: '1',
      episodeTotal: '7',
      quality: 'HD',
      lang: 'Vietnamese',
      actor: ['Actor 9', 'Actor 10'],
      director: ['Director 5'],
      categories: [],
      countries: [japan],
      year: '2023',
    ),
  ];

  static List<Poster> posterList = [
    Poster(
      id: '01',
      name: 'MOVIE1',
      image:
          'https:\/\/phimimg.com\/upload\/vod\/20230929-1\/a6110983f8de490e116383020adc4662.jpg',
    ),
    Poster(
      id: '01',
      name: 'MOVIE1',
      image:
          'https://phimimg.com//upload//vod//20231029-1//134b92a92d78f905d7c60f92a8b03846.jpg',
    ),
    Poster(
      id: '01',
      name: 'MOVIE1',
      image:
          'https://phimimg.com//upload//vod//20240920-1//649b3d26d7f469eddba585430bdf9fb5.jpg',
    ),
  ];

  Constants._();
}
