import 'package:animevn/model/apirespone.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PosterWidget extends StatelessWidget {
  const PosterWidget({super.key,  required this.api});

  final ApiResponse api;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {},
        child: CachedNetworkImage(
          imageUrl: api.posterUrl,
          imageBuilder: (context, imageProvider) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.1),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
              ],
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          progressIndicatorBuilder: (context, url, progress) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey.shade900,
            ),
            child: const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
          errorWidget: (context, url, error) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey.shade800,
            ),
            child: const Icon(Icons.broken_image, color: Colors.white54),
          ),
        ));
  }
}
