import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

//https://pub.dev/packages/flutter_swiper#basic-usage
//https://api.flutter.dev/flutter/widgets/Image/loadingBuilder.html
//https://pub.dev/packages/auto_size_text

class ResultScreen extends StatefulWidget {
  const ResultScreen(this.movieData, this.castData, this.ratingData, {Key? key}) : super(key: key);
  final dynamic movieData;
  final dynamic castData;
  final dynamic ratingData;

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  List actors = [];
  String writer = "";
  String director = "";
  String title = "";
  String poster = "";
  String rating = "";
  bool showActors = false;
  bool showImage = false;

  @override
  void initState() {
    super.initState();
    updateUI(widget.movieData, widget.castData, widget.ratingData);
  }

  void updateUI(dynamic movieData, dynamic castData, dynamic ratingData) {
    setState(() {
      if (castData['actors'] == null ||
          castData['writers']['items'] == [] ||
          castData['directors']['items'] == [] ||
          movieData['results'][0]['image'] == null ||
          ratingData['imDb'] == null) {
        if (castData['actors'].length == 0) {
          actors.add("No Actors");
          showActors = false;
        } else {
          actors = castData['actors'];
          showActors = true;
        }

        if (castData['writers']['items'].length == 0) {
          writer = "No Writer";
        } else {
          writer = castData['writers']['items'][0]['name'];
        }

        if (castData['directors']['items'].length == 0) {
          director = "No Director";
        } else {
          director = castData['directors']['items'][0]['name'];
        }

        if (movieData['results'][0]['title'] == null) {
          title = "No Title";
        } else {
          title = movieData['results'][0]['title'];
        }

        if (movieData['results'][0]['image'] == null) {
          poster = "No Poster";
          showImage = false;
        } else {
          poster = movieData['results'][0]['image'];
          showImage = true;
        }

        if (ratingData['imDb'] == null) {
          rating = "0.0";
        } else {
          rating = ratingData['imDb'];
        }
      } else {
        actors = castData['actors'];
        writer = castData['writers']['items'][0]['name'];
        director = castData['directors']['items'][0]['name'];
        title = movieData['results'][0]['title'];
        poster = movieData['results'][0]['image'];
        rating = ratingData['imDb'];
        showActors = true;
        showImage = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF252631),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const BackButton(
                      color: Colors.white,
                    ),
                    AutoSizeText(
                      title,
                      maxLines: 1,
                      minFontSize: 10,
                      maxFontSize: double.infinity,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.orangeAccent,
                        ),
                        Text(
                          ' $rating',
                          style: const TextStyle(
                              fontSize: 30.0, color: Colors.orangeAccent),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: showImage,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 20.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.network(poster, loadingBuilder:
                        (BuildContext context, Widget child,
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
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
                child: Text(
                  'Directed By:',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 15.0),
                child: Text(
                  director,
                  style: TextStyle(fontSize: 15.0, color: Colors.grey[400]),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
                child: Text(
                  'Written By:',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 15.0),
                child: Text(
                  writer,
                  style: TextStyle(fontSize: 15.0, color: Colors.grey[400]),
                ),
              ),
              Visibility(
                visible: showActors,
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
                  child: Text(
                    'Cast',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
              Visibility(
                visible: showActors,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 20.0),
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: actors.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(actors[index]['name']),
                        subtitle: Text(actors[index]['asCharacter']),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
