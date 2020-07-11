import 'package:slim/slim.dart';
import 'package:tmdb/model/movie.dart';
import 'package:tmdb/model/popular_movies_page.dart';
import 'package:tmdb/model/video_list.dart';

class MovieService extends SlimApi {
  MovieService() : super("https://api.themoviedb.org/3/movie");

  @override
  Map<String, dynamic> createQuery(SlimApiMethod method, {String extra}) =>
      {"api_key": "21cc2fdd836ffd25061f0f849e6e468e"};

  Future<PopularMoviesPage> getPopularMovies(int page) async {
    final response = await get("popular", queryParams: {"page": page});
    return PopularMoviesPage.fromRawJson(response.body);
  }

  Future<VideoList> getVideos(Movie movie) async {
    final response = await get("${movie.id}/videos");
    return VideoList.fromRawJson(response.body);
  }
}
