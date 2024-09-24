import 'package:animate_do/animate_do.dart';
import 'package:animevn/model/apirespone.dart';
import 'package:animevn/screen/videoplayer/videoplayer_screen.dart';
import 'package:animevn/widget/text_button.dart';
import 'package:flutter/material.dart';
import '../../constant/const.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({Key? key, required this.data}) : super(key: key);
  static const routerName = '/movie';
  final ApiResponse data;

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.data.movie.name, style: styleTileAppbar),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: size.height * 0.51,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.data.movie.posterUrl),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Hero(
                    transitionOnUserGestures: true,
                    tag: widget.data.movie.name,
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
                        height: 30, // Chiều cao tùy chỉnh
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                    IconTextButton(icon: Icons.start, text: 'Xem ngay',onPressed: (){
                      Navigator.pushNamed(context, VideoplayerScreen.routerName,
                          arguments: widget.data);
                    },),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Row(
                        children: [
                          Text('The loai: '), Text(
                              widget.data.movie.categories.isNotEmpty
                                  ? widget.data.movie.categories[0].name
                                  : 'Không có dữ liệu'),
                        ],
                      ),
                      Row(
                        children: [
                          Text('So tap: '), Text(widget.data.movie.episodeTotal),
                        ],
                      ),
                    ],),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Row(
                      children: [
                        Text('Nam phat hanh: '), Text(widget.data.movie.year),
                      ],
                    ),
                      Row(
                        children: [
                          Text('Thoi luong: '), Text(widget.data.movie.time),
                        ],
                      ),],),
                    SizedBox(height: 10,),
                    Text('Noi dung: ', style: styleTile,),
                    Text(widget.data.movie.content),


                  ]
                ),
              ),
            ),],
        ),
      ),
    );
  }
}