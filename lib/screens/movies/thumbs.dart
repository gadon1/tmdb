import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:tmdb/controllers/movies_controller.dart';
import 'package:flutter/material.dart';
import 'package:slim/slim.dart';
import 'package:tmdb/screens/widgets/cached_image.dart';

class Thumbs extends SlimWidget<MoviesController> {
  @override
  Widget slimBuild(BuildContext context, MoviesController controller) =>
      controller.popularMovies.isEmpty
          ? Center(child: PlatformCircularProgressIndicator())
          : SingleChildScrollView(
              controller: controller.scrollController,
              child: Wrap(
                children: [
                  for (var page in controller.popularMovies)
                    for (var movie in page.movies)
                      GestureDetector(
                        onTap: () => controller.selectMovie(movie),
                        child: CachedImage(movie, controller.moviePosterWidth,
                            controller.moviePosterHeight),
                      )
                ],
              ),
            );
}
