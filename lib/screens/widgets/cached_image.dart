import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:slim/slim.dart';
import '../../controllers/cached_image_controller.dart';
import '../../model/movie.dart';

class CachedImage extends SlimWidget<CachedImageController> {
  final Movie movie;
  final double width, height;
  final bool poster;
  final Widget stackedWidget;

  CachedImage(this.movie, this.width, this.height,
      {this.poster = true, this.stackedWidget})
      : super(controller: CachedImageController());

  @override
  Widget slimBuild(BuildContext context, CachedImageController controller) =>
      FutureBuilder<Uint8List>(
        future: controller.getImage(movie, poster: poster),
        builder: (context, snapshot) => !snapshot.hasData
            ? Container(
                width: width,
                height: height,
                child: Center(
                  child: PlatformCircularProgressIndicator(),
                ),
              )
            : Stack(
                children: <Widget>[
                  Image.memory(
                    snapshot.data,
                    width: width,
                    height: height,
                    fit: BoxFit.fill,
                  ),
                  stackedWidget ?? SizedBox(height: 0),
                ],
              ),
      );
}
