import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:imdb_brady/services/movie.dart';
import 'home_screen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getImages();
  }

  void getImages() async {
    var m2 = await Movie().getTopMovies();
    var m3 = await Movie().getTopShows();
    List topMovieImages = m2['items'];
    List topShowImages = m3['items'];

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return HomeScreen(topMovieImages, topShowImages);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF252631),
      body: SafeArea(
        child: SpinKitRing(
          color: Colors.blueAccent,
          size: 100.0,
        ),
      ),
    );
  }
}
