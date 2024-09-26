import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constant/constant.dart';
import '../model/movie.dart';
import '../model/poster.dart';

void showToastMessage({
  required String text,
}) {
  Fluttertoast.showToast(
    msg: text,
    backgroundColor: Colors.black54,
    fontSize: 18,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
  );
}

Future<List<Movie>> getMovie()  async {
  await Future.delayed(Duration(seconds: 0));

  final List<Movie> test = Constants.movieList;

  return test;
}

// Future<List<ApiResponse>> getApi() async{
//   await Future.delayed(Duration(seconds: 0));
//   final List<ApiResponse> test = Constants.apiResponseList;
//   return test;
// }

Future<List<Poster>> getPoster() async {
  await Future.delayed(Duration(seconds: 0));
  final List<Poster> test = Constants.posterList;
  return test;
}

final today = DateTime.now();
