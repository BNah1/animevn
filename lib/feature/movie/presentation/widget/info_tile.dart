import 'package:animevn/core/constant/app_color.dart';
import 'package:animevn/core/constant/const.dart';
import 'package:animevn/feature/movie/presentation/view/movie_screen.dart';
import 'package:animevn/model/movie.dart';
import 'package:flutter/material.dart';



class InfoTile extends StatelessWidget {
  const InfoTile({super.key, required this.movie, required this.textColor});

  final Movie movie;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildFieldItemTile(),
        buildItemCategories(),
      ],
    );
  }

  Widget buildFieldItemTile() {
    Widget buildItem(
        {required String name,
        required Color color,
        bool haveBackground = false,
        String? title,
        Gradient? gradient}) {
      final backgroundColor = haveBackground ? color : Colors.transparent;
      return Padding(
        padding: const EdgeInsets.only(
            right: paddingSimple/1.5, bottom: paddingSimple / 2),
        child: Container(
          padding: const EdgeInsets.symmetric(
              vertical: paddingSimple / 2.5, horizontal: paddingSimple),
          decoration: BoxDecoration(
            gradient: gradient,
            color: gradient == null ? null : backgroundColor,
            border:
                haveBackground ? null : Border.all(color: color, width: 1.5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              title != null
                  ? Text(
                      title,
                      style: TextStyle(color: color),
                    )
                  : const SizedBox.shrink(),
              Text(
                name,
                style: TextStyle(color: color, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          buildItem(name: movie.time, color: Colors.yellow),
          buildItem(
              name: 'T ${movie.episodeTotal}',
              gradient: AppColors.buttonGradientColor,
              haveBackground: true,
              color: Colors.black),
          buildItem(name: movie.year, color: Colors.greenAccent),
        ],
      ),
    );
  }

  Widget buildItemCategories() {
    Widget buildItem(String name) {
      return Padding(
        padding: const EdgeInsets.only(right: paddingSimple/1.5),
        child: Container(
          padding: const EdgeInsets.symmetric(
              vertical: paddingSimple / 2.5, horizontal: paddingSimple),
          decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            name,
            style: const TextStyle(color: textDetailColor),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: paddingSimple/2.5),
      child: Wrap(
          alignment: WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.start,
          runAlignment: WrapAlignment.start,
           children: movie.categories.map((e) => buildItem(e.name)).toList()),
    );
  }
}
