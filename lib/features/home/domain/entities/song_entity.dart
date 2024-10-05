
import 'package:hive/hive.dart';
part 'song_entity.g.dart';
@HiveType(typeId:0)
class SongEntity {
  @HiveField(0)
  final String songId;
  @HiveField(1)
  final String? image;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final String? artist;
  @HiveField(4)
  final String? streamingUrl;
  SongEntity(
      {required this.songId,
      required this.image,
      required this.title,
      required this.artist,
      required this.streamingUrl});
}