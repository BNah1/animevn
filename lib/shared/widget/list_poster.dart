import 'package:animevn/feature/home/presentation/widget/poster_widget.dart';
import 'package:animevn/model/poster.dart';
import 'package:animevn/shared/widget/custom_slider_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';

class ListPoster extends StatefulWidget {
  const ListPoster({super.key});

  @override
  _ListPosterState createState() => _ListPosterState();
}

class _ListPosterState extends State<ListPoster> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        height: 400,
        width: double.infinity,
        child: FutureBuilder<List<Poster>>(
            future: getPoster(),
            initialData: const [],
            builder: (context, snapshot) {
              List<Widget> listWidgets = [];
              List<Poster> posterData = snapshot.data!;
              listWidgets = posterData.map((poster) => PosterWidget(path: poster.image)).toList();
              return CustomSliderCard(listWidgets: listWidgets,height: 500);
            }),
      ),
    );
  }
}