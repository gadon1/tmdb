import 'package:slim/slim.dart';
import 'package:tmdb/model/movie.dart';
import 'package:tmdb/services/video_stream_url.dart';
import 'package:video_player/video_player.dart';

class PlayerController extends SlimController {
  VideoPlayerController _videoPlayerController;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onDispose() {
    _videoPlayerController?.dispose();
    super.onDispose();
  }

  int currentMovieId;

  Future<VideoPlayerController> getTrailer(Movie movie) async {
    if (currentMovieId != movie.id) {
      _videoPlayerController = null;
      played = false;
      showPlayerControl = true;
    }
    currentMovieId = movie.id;

    if (_videoPlayerController != null) return _videoPlayerController;
    final response =
        await VideoStreamService().getUrls(movie.videoList.videos.first.key);
    print("video url: ${response.first}");
    _videoPlayerController = VideoPlayerController.network(response.first);
    await _videoPlayerController.initialize();
    return _videoPlayerController;
  }

  play() async {
    if (_videoPlayerController == null) return;
    await _videoPlayerController.play();
    showPlayerControl = false;
    played = true;
    updateUI();
  }

  pause() {
    if (_videoPlayerController == null) return;
    _videoPlayerController.pause();
    showPlayerControl = true;
    updateUI();
  }

  bool played = false;

  bool get isPlaying =>
      (_videoPlayerController == null || _videoPlayerController.value == null)
          ? false
          : _videoPlayerController.value.isPlaying;

  togglePlayerControl() {
    showPlayerControl = !showPlayerControl;
    updateUI();
  }

  bool showPlayerControl = true;
}
