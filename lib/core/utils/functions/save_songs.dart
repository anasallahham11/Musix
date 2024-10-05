import 'package:hive/hive.dart';

import '../../../features/home/domain/entities/song_entity.dart';

void saveSongsData(List<SongEntity> songs,String boxName) {
  var box = Hive.box<SongEntity>(boxName);
  box.addAll(songs);
}