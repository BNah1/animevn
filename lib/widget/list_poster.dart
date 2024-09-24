import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';

class ListPoster extends StatefulWidget {
  const ListPoster({super.key});

  @override
  _ListPosterState createState() => _ListPosterState();
}

class _ListPosterState extends State<ListPoster> {
  int _currentIndex = 0; // Biến để lưu chỉ số hiện tại

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        height: 400,
        width: double.infinity,
        child: FutureBuilder(
            future: getPoster(),
            initialData: const [],
            builder: (context, data) {
              var posterData = data.data!;
              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Positioned.fill(
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: 400,
                        autoPlay: true,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                      ),
                      items: posterData.map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 4.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(i.image),
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  // Chỉ báo nằm ở đây
                  Positioned(
                    bottom: 10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: posterData.asMap().entries.map((entry) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          width: _currentIndex == entry.key ? 12.0 : 8.0,
                          height: 8.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentIndex == entry.key ? Colors.blue : Colors.grey,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}