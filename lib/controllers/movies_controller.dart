import 'package:connectivity_widget/connectivity_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slim/slim.dart';
import 'package:tmdb/model/movie.dart';
import 'package:tmdb/model/popular_movies_page.dart';
import 'package:tmdb/screens/movie_details/movie_details.dart';
import 'package:tmdb/services/movie_service.dart';

class MoviesController extends SlimController {
  static SharedPreferences _sp;
  int currentPage = 0;
  List<Movie> movies = [];
  ScrollController scrollController;
  Movie selectedMovie;
  MovieService movieService = MovieService();
  double wide = 0, maxScrollExtent = 0;

  double get moviePosterWidth => isWideScreen ? wide / 6 : wide / 2;
  double get moviePosterHeight => moviePosterWidth * 1.5;
  bool get isWideScreen => wide > 800;

  void selectMovie(Movie movie) async {
    selectedMovie = movie;
    selectedMovie.videoList ??= await movieService.getVideos(selectedMovie);

    if (isWideScreen)
      updateUI();
    else
      showWidget(Container(child: MovieDetails()));
  }

  @override
  void onDispose() {
    scrollController.dispose();
    super.onDispose();
  }

  @override
  void onInit() async {
    scrollController =
        ScrollController(keepScrollOffset: true, initialScrollOffset: 0)
          ..addListener(inifinteScroll);
    _sp ??= await SharedPreferences.getInstance();
    getMoviesPage();
    super.onInit();
  }

  get _pageKey => 'page$currentPage';

  Future<void> getMoviesPage() async {
    currentPage++;

    if (await ConnectivityUtils.instance.isPhoneConnected()) {
      final page = await movieService.getPopularMovies(currentPage);
      _sp.setString(_pageKey, page.toRawJson());
      movies.addAll(page.movies);
      updateUI();
      return;
    }

    if (_sp.containsKey(_pageKey)) {
      final page = PopularMoviesPage.fromRawJson(_sp.getString(_pageKey));
      _sp.setString(_pageKey, page.toRawJson());
      movies.addAll(page.movies);
      updateUI();
      return;
    }

    currentPage--;

    Future.delayed(Duration.zero,
        () => showWidget(PlatformText("No Internet Connection")));
  }

  void inifinteScroll() async {
    final maxScroll = 0.7 * scrollController.position.maxScrollExtent;
    if (maxScroll - maxScrollExtent > 200) {
      final currentScroll = scrollController.position.pixels;
      if (currentScroll >= maxScroll && maxScrollExtent != maxScroll) {
        maxScrollExtent = maxScroll;
        await getMoviesPage();
      }
    }
  }
}
