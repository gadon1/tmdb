import 'package:slim/slim.dart';
import '../model/movie.dart';

class ImageService extends SlimApi {
  ImageService() : super(IMAGE_URL);

  Future<SlimResponse> downloadImage(String url) =>
      get(url.replaceFirst('/', ''));
}
