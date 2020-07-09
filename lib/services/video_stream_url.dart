import 'dart:convert';

import 'package:http/http.dart' as http;

class VideoStreamService {
  String _parseAdaptiveFormat(adaptiveFormat) {
    var res = (adaptiveFormat['url'] ?? adaptiveFormat['cipher']).toString();
    res = Uri.decodeQueryComponent(res.substring(res.indexOf('https')));
    res = res.replaceFirst("&c=WEB", "");
    return res;
  }

  bool _isVideo(adaptiveFormat) {
    return adaptiveFormat['mimeType'].toString().startsWith('video');
  }

  Future<List<String>> getUrls(String url) async {
    var videoStreams = List<String>();
    try {
      var surl =
          "https://www.youtube.com/get_video_info?video_id=$url&eurl=https://youtube.googleapis.com/v/$url";
      var res = await http.get(surl);
      var params = res.body.split('&');
      for (var i = 0; i < params.length; i++) {
        if (params[i].startsWith('player_response')) {
          params[i] = Uri.decodeQueryComponent(params[i]);
          var json = jsonDecode(params[i].substring(16));
          var adaptiveFormats = json['streamingData']['formats'];
          for (var j = 0; j < adaptiveFormats.length; j++) {
            if (_isVideo(adaptiveFormats[j]))
              videoStreams.add(_parseAdaptiveFormat(adaptiveFormats[j]));
          }
          videoStreams.add(json['videoDetails']['title']);
        }
      }
    } catch (e) {}
    return videoStreams;
  }
}
