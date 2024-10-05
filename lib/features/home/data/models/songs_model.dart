// To parse this JSON data, do
//
//     final songsModel = songsModelFromJson(jsonString);

import 'dart:convert';

import 'package:musix/features/home/domain/entities/song_entity.dart';

List<SongsModel> songsModelFromJson(String str) => List<SongsModel>.from(json.decode(str).map((x) => SongsModel.fromJson(x)));

String songsModelToJson(List<SongsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SongsModel extends SongEntity{
  String? artistM;
  String? imageM;
  String? titleM;
  String? streamingUrlM;
  String? idM;

  SongsModel({
    this.artistM,
    this.imageM,
    this.titleM,
    this.streamingUrlM,
    this.idM,
  }):super(
    songId:idM!,
    artist:artistM,
    image: imageM,
    title: titleM!,
    streamingUrl: streamingUrlM,



  );

  factory SongsModel.fromJson(Map<String, dynamic> json) => SongsModel(
    artistM: json["artist"],
    imageM: json["image"],
    titleM: json["title"],
    streamingUrlM: json["streamingUrl"],
    idM: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "artist": artistM,
    "image": imageM,
    "title": titleM,
    "streamingUrl": streamingUrlM,
    "id": idM,
  };
}
