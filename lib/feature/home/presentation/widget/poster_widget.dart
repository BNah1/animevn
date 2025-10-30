import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PosterWidget extends StatelessWidget {
  const PosterWidget({super.key, required this.path});

  final String path;

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: (){
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: CachedNetworkImageProvider(path),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

