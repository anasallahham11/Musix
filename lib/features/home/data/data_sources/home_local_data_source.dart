import 'package:musix/constants.dart';
import 'package:hive/hive.dart';

import '../../domain/entities/song_entity.dart';

abstract class HomeLocalDataSource {
  List<SongEntity> fetchFeaturedSongs({int pageNumber=0});
  List<SongEntity> fetchAllSongs();
}

class HomeLocalDataSourceImpl extends HomeLocalDataSource{

  @override
  List<SongEntity> fetchFeaturedSongs({int pageNumber=0}) {
    int startIndex=pageNumber*10;
    int endIndex=startIndex+10;
    var box = Hive.box<SongEntity>(kFeaturedBox);
    int length=box.values.length;
    if(startIndex>=length || endIndex>length) {
      return [];
    }
    return box.values.toList().sublist(startIndex,endIndex);
  }

  @override
  List<SongEntity> fetchAllSongs() {
    var box = Hive.box<SongEntity>(kAllBox);
    return box.values.toList();
  }


}