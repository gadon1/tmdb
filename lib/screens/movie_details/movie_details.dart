import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:slim/slim.dart';
import 'package:tmdb/controllers/movies_controller.dart';
import 'package:tmdb/screens/widgets/movie_info/movie_info.dart';

class MovieDetails extends SlimWidget<MoviesController> {
  @override
  Widget slimBuild(BuildContext context, MoviesController controller) =>
      PlatformScaffold(
        appBar: PlatformAppBar(
          title: PlatformText('Movie Details'),
          material: (context, platform) =>
              MaterialAppBarData(centerTitle: true),
          leading: InkWell(
            child: Icon(
              context.platformIcons.back,
              color: Colors.white,
            ),
            onTap: context.forceClearOverlay,
          ),
        ),
        iosContentPadding: true,
        body: ListView(padding: EdgeInsets.zero, children: [
          MovieInfo(controller),
        ]),
      );
}
