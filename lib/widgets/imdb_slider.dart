import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class IMDBSlider extends StatelessWidget {
  const IMDBSlider({
    Key? key,
    required this.topMovieImages,
    required this.title,
  }) : super(key: key);

  final List topMovieImages;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 20.0, 0.0, 0.0),
          child: Text(
            title,
            textAlign: TextAlign.left,
            style: const TextStyle(fontSize: 25.0),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 10.0),
          child: CarouselSlider.builder(
            options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 2.0,
              enlargeCenterPage: false,
              viewportFraction: 1,
            ),
            itemCount: (topMovieImages.length / 2).round(),
            itemBuilder: (context, index, realIdx) {
              final int first = index * 2;
              final int second = first + 1;
              return Row(
                children: [first, second].map((idx) {
                  return Expanded(
                    flex: 1,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Image.network(topMovieImages[idx]['image'],
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      }),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ),
      ],
    );
  }
}
