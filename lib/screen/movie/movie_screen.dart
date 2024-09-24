import 'package:animate_do/animate_do.dart';
import 'package:animevn/model/movie.dart';
import 'package:animevn/widget/text_button.dart';
import 'package:flutter/material.dart';
import '../../constant/const.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({Key? key, required this.movie}) : super(key: key);
  static const routerName = '/movie';
  final Movie movie;

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        title: Text(widget.movie.name, style: styleTileAppbar),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: size.height * 0.51,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
                    image: DecorationImage(
                      image: NetworkImage(widget.movie.posterUrl),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Hero(
                    transitionOnUserGestures: true,
                    tag: widget.movie.name,
                    child: Container(),
                  ),
                ),
                // Widget cho phần dưới của SliverAppBar
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: FadeInUp(
                    duration: Duration(milliseconds: 500),
                    child: Transform.translate(
                      offset: const Offset(0, 1),
                      child: Container(
                        height: 50, // Chiều cao tùy chỉnh
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                        child: Column(
                          children: [
                            Center(
                              child: Container(
                                height: 9,
                                width: 45,
                                decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            FadeInUp(
              duration: Duration(milliseconds: 500),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('Nam phat hanh: '), Text(widget.movie.year),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Thoi luong: '), Text(widget.movie.time),
                      ],
                    ),
                    Row(
                      children: [
                        Text('The loai: '), Text(widget.movie.categories[0].name),
                      ],
                    ),
                    Row(
                      children: [
                        Text('So tap: '), Text(widget.movie.episodeTotal),
                      ],
                    ),
                    IconTextButton(icon: Icons.start, text: 'Xem ngay'),
                  ]
                ),
              ),
            ),],
        ),
      ),
    );
  }
}