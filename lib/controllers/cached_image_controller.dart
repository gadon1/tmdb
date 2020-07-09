import 'dart:convert';
import 'dart:typed_data';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slim/slim.dart';
import '../services/image_service.dart';
import '../model/movie.dart';

class CachedImageController extends SlimController {
  static SharedPreferences _sp;
  int currentMovieId;
  Uint8List bytes;
  Future<Uint8List> getImage(Movie movie, {bool poster = true}) async {
    if (bytes != null && currentMovieId == movie.id) return bytes;
    currentMovieId = movie.id;
    _sp ??= await SharedPreferences.getInstance();
    final key = poster
        ? movie.posterPath ?? movie.backdropPath
        : movie.backdropPath ?? movie.posterPath;
    if (_sp.containsKey(key))
      bytes = base64Decode(_sp.getString(key));
    else {
      final res = await ImageService().downloadImage(key);
      bytes = res.bytes;
      await _sp.setString(key, base64Encode(bytes));
    }
    return bytes;
  }
}
