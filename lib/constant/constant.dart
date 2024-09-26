import 'package:animevn/model/episode.dart';
import 'package:flutter/material.dart';

import '../model/category.dart';
import '../model/movie.dart';
import '../model/movie/country.dart';
import '../model/poster.dart';

class Constants {

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






  // demo to test UI
  static const String testImage =
      'https://images.unsplash.com/photo-1517404215738-15263e9f9178?q=80&w=4114&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';

  static const String maleProfilePic =
      'https://jeremyveldman.com/wp-content/uploads/2019/08/Generic-Profile-Pic.jpg';

  static const String profilePicBlank =
      'https://t3.ftcdn.net/jpg/05/16/27/58/240_F_516275801_f3Fsp17x6HQK0xQgDQEELoTuERO4SsWV.jpg';

  static const String testVideoUrl = 'https://s2.phim1280.tv/20230907/S7BVCpM0/index.m3u8';


  static  Category action = Category(id: '1', name: 'Action');
  static  Category drama = Category(id: '2', name: 'Drama');
  static  Country usa = Country(id: '1', name: 'USA', slug: '');
  static  Country uk = Country(id: '2', name: 'UK', slug: '');
  static  Country japan = Country(id: '3', name: 'Japan', slug: '');
  static String content = 'Phim lấy bối cảnh vào đầu mùa thu năm 2012 tại một trường trung học phổ thông danh tiếng của thành phố Z. Câu chuyện bắt đầu khi nhân vật chính, Tô Tại Tại, trúng tuyển và bước vào trường mới. Ngay từ ngày đầu tiên đến trường, cô bị thu hút bởi Trương Lực Nhượng - một học sinh có tính cách ấm áp và lạc quan như ánh mặt trời. Tình cảm giữa hai người bắt đầu chớm nở khi Tô Tại Tại giúp Trương Lực Nhượng vượt qua sự tự ti, còn Trương Lực Nhượng dần dần giúp cô nhận ra cách lập kế hoạch và mục tiêu cho cuộc sống của mình.\n\nPhim khắc họa những rung động, bỡ ngỡ của tuổi trẻ, cũng như cách các nhân vật dần trưởng thành, tự tìm thấy bản thân và hướng tới một tương lai tươi sáng.';
  static Movie movie1 =  Movie(
    id: '1',
    name: 'Movie 1',
    originName: 'Phim 1',
    content: content,
    type: 'Hành động',
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
      episodes: episode1
  );
  static Movie movie2 =  Movie(
    id: '2',
    name: 'Movie 2',
    originName: 'Phim 2',
    content: content,
    type: 'Hài',
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
      episodes: episode1
  );
  static Movie movie3 =  Movie(
    id: '3',
    name: 'Movie 3',
    originName: 'Phim 3',
    content: content,
    type: 'Kinh dị',
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
      episodes: episode1
  );
  static Movie movie4 =  Movie(
    id: '4',
    name: 'Movie 4',
    originName: 'Phim 4',
    content: content,
    type: 'Phiêu lưu',
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
      episodes: episode1
  );
  static Movie movie5 =  Movie(
    id: '5',
    name: 'Movie 5',
    originName: 'Phim 5',
    content: content,
    type: 'Phiêu lưu',
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
      episodes: episode1
  );

  static EpisodeData data1 = EpisodeData(slug: 'Tap 1', link_m3u8: 'https:\/\/s2.phim1280.tv\/20230907\/S7BVCpM0\/index.m3u8');
  static EpisodeData data2 = EpisodeData(slug: 'Tap 2', link_m3u8: 'https:\/\/s2.phim1280.tv\/20230907\/IvNmZP16\/index.m3u8');
  static EpisodeData data3 = EpisodeData(slug: 'Tap 3', link_m3u8: 'https:\/\/s2.phim1280.tv\/20230907\/VOdl4WMe\/index.m3u8');
  static EpisodeData data4 = EpisodeData(slug: 'Tap 4', link_m3u8: 'ttps:\/\/s2.phim1280.tv\/20230907\/daZYcVlQ\/index.m3u8');

  static Episode episode1 = Episode(serverName: 'Wibu', serverData: [data1, data2, data3, data4]);
  static List<Movie> movieList = [movie1, movie2, movie3, movie4, movie5 ];


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
