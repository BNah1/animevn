import 'package:flutter/material.dart';

import '../../model/poster.dart';

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
          index == 1 ? Icons.local_fire_department : Icons.local_fire_department_outlined,
          color: Colors.blue,
        ),
      ),
      Tab(
        icon: Icon(
          index == 2 ? Icons.favorite : Icons.favorite_border,
          color: Colors.blue,
        ),
      ),
      Tab(
        icon: Icon(
          index == 3 ? Icons.remove_red_eye : Icons.remove_red_eye_outlined,
          color: Colors.blue,
        ),
      ),
    ];
  }

  static List<Poster> posterList = [
    Poster(
      id: '01',
      name: 'MOVIE1',
      image:
          'https://phimimg.com\/upload\/vod\/20230929-1//a6110983f8de490e116383020adc4662.jpg',
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
