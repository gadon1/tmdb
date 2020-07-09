import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:slim/slim.dart';
import 'package:tmdb/controllers/movies_controller.dart';
import 'package:tmdb/controllers/player_controller.dart';
import 'package:video_player/video_player.dart';

class Player extends SlimWidget<PlayerController> {
  final MoviesController moviesController;
  Player(this.moviesController) : super(controller: PlayerController());

  @override
  Widget slimBuild(BuildContext context, PlayerController controller) => Stack(
        children: <Widget>[
          FutureBuilder<VideoPlayerController>(
            future: controller.getTrailer(moviesController.selectedMovie),
            builder: (context, snapshot) => !snapshot.hasData
                ? SizedBox(height: 0)
                : Container(
                    width: moviesController.isWideScreen
                        ? context.width / 2
                        : context.width,
                    height: (controller.isPlaying || controller.played)
                        ? context.height / 3
                        : 0,
                    child: InkWell(
                      child: AspectRatio(
                        child: VideoPlayer(snapshot.data),
                        aspectRatio: 1,
                      ),
                      onTap: controller.togglePlayerControl,
                    ),
                  ),
          ),
          Visibility(
            visible: controller.showPlayerControl,
            child: Container(
              width: moviesController.isWideScreen
                  ? context.width / 2
                  : context.width,
              height: context.height / 3,
              child: Center(
                child: Transform.scale(
                  scale: 3,
                  child: PlatformIconButton(
                    icon: Icon(
                      controller.isPlaying
                          ? context.platformIcons.pause
                          : context.platformIcons.playArrow,
                      color: Colors.white,
                    ),
                    onPressed: controller.isPlaying
                        ? controller.pause
                        : controller.play,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
}
