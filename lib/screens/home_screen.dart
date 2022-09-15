import 'package:flutter/material.dart';
import 'package:imdb_brady/screens/result_screen.dart';
import 'package:imdb_brady/services/movie.dart';
import 'package:imdb_brady/widgets/imdb_slider.dart';

//https://pub.dev/packages/flutter_swiper#basic-usage
//https://stackoverflow.com/questions/46551268/when-the-keyboard-appears-the-flutter-widgets-resize-how-to-prevent-this

class HomeScreen extends StatefulWidget {
  const HomeScreen(this.topMovieImages, this.topShowImages, {Key? key}) : super(key: key);
  final List topMovieImages;
  final List topShowImages;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF252631),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Welcome!',
                    style: TextStyle(fontSize: 30.0),
                  ),
                  Text(
                    'Search your favorite movies and TV shows',
                    style: TextStyle(fontSize: 15.0, color: Colors.blueGrey),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFF3c3e4d),
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              margin: const EdgeInsets.all(20.0),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    suffix: isLoading
                        ? const SizedBox(
                            height: 20.0,
                            width: 20.0,
                            child: Center(child: CircularProgressIndicator()),
                          )
                        : null,
                    border: InputBorder.none,
                    icon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    hintText: 'Search',
                  ),
                  onSubmitted: (String text2) async {
                    String text = text2.toString();
                    if (text != "") {
                      setState(() {
                        isLoading = true;
                      });
                      var m1 = await Movie().getMovie(text);
                      var m2 = await Movie().getCast(m1['results'][0]['id']);
                      var m3 = await Movie().getRating(m1['results'][0]['id']);
                      if (m1 != null || m2 != null || m3 != null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ResultScreen(m1, m2, m3)));
                        setState(() {
                          isLoading = false;
                        });
                      }
                    }
                  },
                ),
              ),
            ),
            IMDBSlider(
              topMovieImages: widget.topMovieImages,
              title: 'Top 250 Movies',
            ),
            IMDBSlider(
              topMovieImages: widget.topShowImages,
              title: 'Top 250 Shows',
            ),
          ],
        ),
      ),
    );
  }
}
