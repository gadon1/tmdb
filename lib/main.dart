import 'package:connectivity_widget/connectivity_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:slim/slim.dart';
import 'package:tmdb/controllers/movies_controller.dart';
import 'screens/movies/movies.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ConnectivityUtils.initialize(
      serverToPing:
          "https://gist.githubusercontent.com/Vanethos/dccc4b4605fc5c5aa4b9153dacc7391c/raw/355ccc0e06d0f84fdbdc83f5b8106065539d9781/gistfile1.txt",
      callback: (response) => response.contains("This is a test!"));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      [Slimer<MoviesController>(MoviesController())].slim(
        child: PlatformProvider(
          //initialPlatform: TargetPlatform.iOS,
          builder: (context) => PlatformApp(
            debugShowCheckedModeBanner: false,
            material: (context, platform) => MaterialAppData(
              builder: SlimMaterialAppBuilder.builder,
              title: 'Sphereo Test',
              theme: ThemeData(
                primarySwatch: Colors.blue,
                visualDensity: VisualDensity.adaptivePlatformDensity,
                brightness: Brightness.dark,
              ),
              home: Movies(),
            ),
            cupertino: (context, platform) => CupertinoAppData(
              builder: SlimMaterialAppBuilder.builder,
              title: 'Sphereo Test',
              theme: CupertinoThemeData(
                brightness: Brightness.dark,
              ),
              home: Movies(),
            ),
          ),
        ),
      );
}
