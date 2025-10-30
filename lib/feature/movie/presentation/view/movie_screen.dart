import 'package:animate_do/animate_do.dart';
import 'package:animevn/core/bloc/movie/movie_bloc.dart';
import 'package:animevn/core/bloc/movie/movie_event.dart';
import 'package:animevn/core/bloc/movie/movie_state.dart';
import 'package:animevn/core/constant/const.dart';
import 'package:animevn/feature/favourite_movie/presentation/state/bloc/storage_bloc.dart';
import 'package:animevn/feature/favourite_movie/presentation/state/bloc/storage_event.dart';
import 'package:animevn/feature/movie/presentation/widget/info_tile.dart';
import 'package:animevn/feature/movie/presentation/widget/list_action_button_movie.dart';
import 'package:animevn/feature/video_play/presentation/view/videoplayer_screen.dart';
import 'package:animevn/shared/widget/icon_text_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../favourite_movie/presentation/state/bloc/storage_state.dart';
import '../../../../model/movie.dart';
import '../../../../shared/widget/loading.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({Key? key, required this.linkMovie, required this.pathImage}) : super(key: key);
  static const routerName = '/movie';
  final String linkMovie;
  final String pathImage;

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  late bool isFavourite;
  late Movie movie;

  @override
  void initState() {
    context.read<MovieBloc>().add(LoadMovieByUrl(widget.linkMovie));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<MovieBloc, MovieState>(builder: (context, state) {
      if (state is MovieLoading) {
        return buildImageAppBar(isLoading: true);
      } else if (state is MovieError) {
        return Center(
          child: Text(state.message),
        );
      } else if (state is MovieLoaded) {
        movie = state.movie;
        return Scaffold(
            backgroundColor: Colors.white,
            body: Stack(
              children: [
                buildBody(size),

                buildButtonAppBar(),
              ],
            ));
      }
      return Container();
    });
  }
  
  Widget buildBody(Size size){
    final height = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Stack(
        children: [
          Stack(
            children: [

              buildImageAppBar(),

              // Widget cho phần dưới của SliverAppBar
              Positioned(
                bottom: height/2,
                left: 0,
                right: 0,
                child: buildBodyContainer(),
              ),
            ],
          ),

          buildDetailBody(movie)
        ],
      ),
    );
  }

  Widget buildButtonAppBar(){
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 10, vertical: 30),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildExitButton(),
            buildFavouriteButton()
          ]),
    );
  }

  Widget buildImageAppBar({bool isLoading = false}){
    final height = MediaQuery.of(context).size.height;
    return Hero(
      tag: widget.pathImage,
      child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          height: height,
      
          // height: isLoading ? height : height / 2,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: CachedNetworkImageProvider(widget.pathImage),
              fit: BoxFit.fill,
            ),
          ),
          child: isLoading ? const Loader() : null
      ),
    );
  }

  Widget buildDetailBody(Movie movie) {
    final height = MediaQuery.of(context).size.height;

    return FadeInUp(
      duration: const Duration(milliseconds: 500),
      child: Padding(
        padding: EdgeInsets.only(top: height/2),
        child: Container(
          padding: EdgeInsets.all(15),
          color: Colors.white,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

            buildWatchButton(movie),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: paddingSimple),
              child: Text(movie.name,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
            ),

            InfoTile(movie: movie),
            buildContentTile(movie),
            const ListActionButtonMovie(),
            const SizedBox(height: 80,)
          ]),

        ),
      ),
    );
  }
  
  Widget buildContentTile(Movie movie){

    Widget button(){
      return  InkWell(
        onTap: (){
          print('showBottom');
        },
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Text('Chi tiết',style: TextStyle(fontWeight: FontWeight.bold),),
          Icon(Icons.arrow_drop_down_rounded,size: 50,)
        ],),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: paddingSimple),
      child: Row(children: [
        Expanded(child: Text(movie.content,overflow: TextOverflow.ellipsis,maxLines: 4,)),
        button()
      ],),
    );
  }


  Widget buildBodyContainer(){
    return FadeInUp(
      duration: const Duration(milliseconds: 500),
      child: Transform.translate(
        offset: const Offset(0, 1),
        child: Container(
          height: 30, // Chiều cao tùy chỉnh
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          child: Column(
            mainAxisAlignment:
            MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  height: 9,
                  width: 45,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius:
                    BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildWatchButton(Movie movie) {
    return IconTextButton(
      padding: 0,
      icon: Icons.play_arrow_rounded,
      text: 'Xem phim',
      onPressed: () {
        context.read<StorageBloc>().add(AddToStorage(
            name: movie.name,
            slug: movie.slug,
            originName: movie.originName,
            posterUrl: movie.posterUrl,
            thumbUrl: movie.thumbUrl,
            year: movie.year));
        context.read<StorageBloc>().add(SeenApiStatus(widget.linkMovie));
        Navigator.pushNamed(context, VideoplayerScreen.routerName,
            arguments: movie);
      },
    );
  }

  Widget buildExitButton() {
    return InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
            padding: const EdgeInsets.all(2),
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black26,
                border: Border.all(color: Colors.white)),
            child: const FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  'x',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ))));
  }

  Widget buildFavouriteButton() {
    return BlocBuilder<StorageBloc, StorageState>(
      builder: (context, storageState) {
        isFavourite = storageState.items[widget.linkMovie]?.favourite ?? false;

        return InkWell(
          onTap: () {
            context.read<StorageBloc>().add(
                  AddToStorage(
                    name: movie.name,
                    slug: widget.linkMovie,
                    originName: movie.originName,
                    posterUrl: movie.posterUrl,
                    thumbUrl: movie.thumbUrl,
                    year: movie.year,
                  ),
                );

            context
                .read<StorageBloc>()
                .add(FavouriteApiStatus(widget.linkMovie));
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(
              size: 40,
              Icons.favorite,
              color: isFavourite ? Colors.red : Colors.grey,
            ),
          ),
        );
      },
    );
  }
}
