import 'package:animate_do/animate_do.dart';
import 'package:animevn/bloc/movie/movie_bloc.dart';
import 'package:animevn/bloc/movie/movie_event.dart';
import 'package:animevn/bloc/movie/movie_state.dart';
import 'package:animevn/screen/videoplayer/videoplayer_screen.dart';
import 'package:animevn/widget/text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constant/const.dart';
import '../../widget/loading.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({Key? key, required this.linkMovie}) : super(key: key);
  static const routerName = '/movie';
  final String linkMovie;

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(create: (context) => MovieBloc()..add(LoadMovieByUrl(widget.linkMovie)),
    child: BlocBuilder<MovieBloc, MovieState>(builder: (context, state){
      if (state is MovieLoading) {
        return Loader();
      } else if (state is MovieError) {
        return Center(
          child: Text(state.message),
        );
      } else if (state is MovieLoaded) {
        return  Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Center(
            child: Text(state.movie.name,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                softWrap: true,
                style: styleTileAppbar),
          ),
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
                        image: NetworkImage(state.movie.posterUrl),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Hero(
                      transitionOnUserGestures: true,
                      tag: state.movie.name,
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
                              arguments: state.movie);
                        },),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            Text('Thể loại: '),
                            Text(
                              state.movie.categories.isNotEmpty
                                  ? state.movie.categories.map((category) => category.name).join(', ')
                                  : 'Không có dữ liệu',
                            )

                          ],
                        ),
                        Row(
                          children: [
                            Text('Số tập: '),
                            Text(state.movie.episodeTotal),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Thời lượng: '),
                            Text(state.movie.time),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Năm phát hành: '), Text(state.movie.year),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Text('Nội dung: ', style: styleTile,),
                        Text(state.movie.content),
                      ]
                  ),
                ),
              ),],
          ),
        ),
      );}
      return Container();
    }
    ),);
  }
}