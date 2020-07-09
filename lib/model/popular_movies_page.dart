import 'dart:convert';
import 'movie.dart';

class PopularMoviesPage {
  PopularMoviesPage({
    this.page,
    this.totalResults,
    this.totalPages,
    this.movies,
  });

  int page;
  int totalResults;
  int totalPages;
  List<Movie> movies;

  factory PopularMoviesPage.fromRawJson(String str) =>
      PopularMoviesPage.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PopularMoviesPage.fromJson(Map<String, dynamic> json) =>
      PopularMoviesPage(
        page: json["page"],
        totalResults: json["total_results"],
        totalPages: json["total_pages"],
        movies: List<Movie>.from(json["results"].map((x) => Movie.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "total_results": totalResults,
        "total_pages": totalPages,
        "results": List<dynamic>.from(movies.map((x) => x.toJson())),
      };
}
