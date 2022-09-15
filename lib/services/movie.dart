import 'package:imdb_brady/services/networking.dart';

class Movie {
  Future<dynamic> getMovie(String name) async {
    NetworkHelper n1 =
        NetworkHelper('https://imdb-api.com/en/API/Search/k_0fliij36/$name');
    return await n1.getData();
  }

  Future<dynamic> getCast(String id) async {
    NetworkHelper n1 =
        NetworkHelper('https://imdb-api.com/en/API/FullCast/k_0fliij36/$id');
    return await n1.getData();
  }

  Future<dynamic> getRating(String id) async {
    NetworkHelper n1 =
        NetworkHelper('https://imdb-api.com/en/API/Ratings/k_0fliij36/$id');
    return await n1.getData();
  }

  Future<dynamic> getTopMovies() async {
    NetworkHelper n1 =
        NetworkHelper('https://imdb-api.com/en/API/Top250Movies/k_0fliij36');
    return await n1.getData();
  }

  Future<dynamic> getTopShows() async {
    NetworkHelper n1 =
        NetworkHelper('https://imdb-api.com/en/API/Top250TVs/k_0fliij36');
    return await n1.getData();
  }
}
