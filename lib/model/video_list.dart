import 'dart:convert';
import 'video.dart';

class VideoList {
  VideoList({
    this.id,
    this.videos,
  });

  int id;
  List<Video> videos;

  factory VideoList.fromRawJson(String str) =>
      VideoList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory VideoList.fromJson(Map<String, dynamic> json) => VideoList(
        id: json["id"],
        videos: List<Video>.from(json["results"].map((x) => Video.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "results": List<dynamic>.from(videos.map((x) => x.toJson())),
      };
}
