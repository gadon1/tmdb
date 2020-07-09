import 'package:connectivity_widget/connectivity_widget.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:tmdb/controllers/movies_controller.dart';
import 'package:flutter/material.dart';
import 'package:slim/slim.dart';
import 'package:tmdb/screens/widgets/movie_info/movie_info.dart';
import 'thumbs.dart';

class Movies extends SlimWidget<MoviesController> {
  @override
  Widget slimBuild(BuildContext context, MoviesController controller) =>
      PlatformScaffold(
        appBar: PlatformAppBar(
          title: PlatformText('Popular Movies'),
          material: (context, platform) =>
              MaterialAppBarData(centerTitle: true),
          trailingActions: <Widget>[
            ConnectivityWidget(
              showOfflineBanner: false,
              builder: (context, isOnline) => Container(
                alignment: Alignment.center,
                child: PlatformText(
                  isOnline ? 'Online' : 'Offline',
                  style: TextStyle(
                      color: isOnline ? Colors.blue : Colors.red, fontSize: 12),
                ),
              ),
            )
          ],
        ),
        iosContentPadding: true,
        body: LayoutBuilder(
          builder: (context, constraints) =>
              (controller..wide = constraints.biggest.width).isWideScreen
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Thumbs(),
                          width: controller.moviePosterWidth * 3,
                        ),
                        Expanded(
                          child: Container(
                            child: MovieInfo(controller),
                          ),
                        )
                      ],
                    )
                  : Thumbs(),
        ),
      );
}
