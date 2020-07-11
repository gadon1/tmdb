import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:slim/slim.dart';
import 'package:tmdb/controllers/movies_controller.dart';
import 'package:tmdb/screens/widgets/cached_image.dart';
import 'package:tmdb/screens/widgets/player.dart';
import '../../../model/movie.dart';
import '../rate/rate.dart';

class MovieInfo extends StatelessWidget {
  final MoviesController controller;
  Movie get movie => controller.selectedMovie;
  MovieInfo(this.controller);
  @override
  Widget build(BuildContext context) => movie == null
      ? Center(
          child: PlatformText('select movie'),
        )
      : SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CachedImage(
                movie,
                controller.isWideScreen ? context.width / 2 : context.width,
                context.height / 3,
                poster: false,
                stackedWidget: Player(controller),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      PlatformText(
                        movie.title,
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            .copyWith(color: Colors.white),
                      ),
                      SizedBox(height: 5),
                      PlatformText(
                        "${movie.releaseDate.format('dd/mm/yyyy')}",
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(color: Colors.white),
                      ),
                      Rate(movie.voteAverage / 10),
                      SizedBox(height: 10),
                      PlatformText(
                        movie.overview,
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
}
