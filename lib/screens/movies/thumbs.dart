import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:tmdb/controllers/movies_controller.dart';
import 'package:flutter/material.dart';
import 'package:slim/slim.dart';
import 'package:tmdb/screens/widgets/cached_image.dart';

class Thumbs extends SlimWidget<MoviesController> {
  @override
  Widget slimBuild(BuildContext context, MoviesController controller) =>
      controller.movies.isEmpty
          ? Center(child: PlatformCircularProgressIndicator())
          : GridView.count(
              semanticChildCount: controller.movies.length,
              controller: controller.scrollController,
              crossAxisCount: controller.isWideScreen ? 3 : 2,
              cacheExtent: controller.moviePosterHeight * 3,
              childAspectRatio: 2 / 3,
              children: <Widget>[
                ...controller.movies.map((e) => GestureDetector(
                      onTap: () => controller.selectMovie(e),
                      child: CachedImage(e, controller.moviePosterWidth,
                          controller.moviePosterHeight),
                    ))
              ],
            );
}
