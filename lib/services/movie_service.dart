import 'package:slim/slim.dart';
import 'package:tmdb/model/movie.dart';
import 'package:tmdb/model/popular_movies_page.dart';
import 'package:tmdb/model/video_list.dart';

class MovieService extends SlimApi {
  MovieService() : super("https://api.themoviedb.org/3/movie");

  String _addApiKey(String serviceUrl) =>
      "$serviceUrl${serviceUrl.contains('?') ? '&' : '?'}api_key=21cc2fdd836ffd25061f0f849e6e468e";

  @override
  Future<SlimResponse> post(String serviceUrl, body, {String extra}) =>
      super.post(_addApiKey(serviceUrl), body, extra: extra);

  @override
  Future<SlimResponse> get(String serviceUrl, {String extra}) =>
      super.get(_addApiKey(serviceUrl), extra: extra);

  Future<PopularMoviesPage> getPopularMovies(int page) async {
    final response = await getMovies(page: page);
    return PopularMoviesPage.fromRawJson(response.body);
  }

  Future<VideoList> getVideos(Movie movie) async {
    final response = await get("${movie.id}/videos");
    return VideoList.fromRawJson(response.body);
  }

  Future<SlimResponse> getMovies({int page = 1}) => get("popular?page=$page");
}
