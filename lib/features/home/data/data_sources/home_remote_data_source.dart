import 'package:musix/constants.dart';
import 'package:musix/core/utils/api_service.dart';
import 'package:musix/core/utils/endpoints.dart';
import 'package:musix/features/home/data/models/songs_model.dart';
import 'package:musix/features/home/domain/entities/song_entity.dart';
import 'package:dio/dio.dart';
import '../../../../core/utils/functions/save_songs.dart';

abstract class HomeRemoteDataSource {
  Future<List<SongEntity>> fetchFeaturedSongs({int pageNumber=0});
  Future<List<SongEntity>> fetchAllSongs();
}
class HomeRemoteDataSourceImpl extends HomeRemoteDataSource{
  @override
  Future<List<SongEntity>> fetchFeaturedSongs({int pageNumber=0}) async{
    var response = await ApiService.getData(url: featuredSongsApi);
    List<SongEntity> songs = getSongsList(response);
    saveSongsData(songs,kFeaturedBox);
    return songs;
  }



  @override
  Future<List<SongEntity>> fetchAllSongs() async{
    var response = await ApiService.getData(url: allSongsApi);
    List<SongEntity> songs = getSongsList(response);
    saveSongsData(songs, kAllBox);
    return songs;
  }

  List<SongEntity> getSongsList(Response<dynamic>? response) {
    List<SongEntity> songs=[];
    for(var song in response?.data){
      songs.add(SongsModel.fromJson(song));
    }
    return songs;
  }

}