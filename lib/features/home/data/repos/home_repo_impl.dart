import 'package:musix/core/errors/failure.dart';
import 'package:musix/features/home/data/data_sources/home_local_data_source.dart';
import 'package:musix/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:musix/features/home/domain/entities/song_entity.dart';
import 'package:musix/features/home/domain/repos/home_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class HomeRepoImpl extends HomeRepo {
  final HomeRemoteDataSource homeRemoteDataSource;
  final HomeLocalDataSource homeLocalDataSource;

  HomeRepoImpl({required this.homeRemoteDataSource,required this.homeLocalDataSource});


  @override
  Future<Either<Failure, List<SongEntity>>> fetchFeaturedSongs({int pageNumber=0}) async{
    try {
      List<SongEntity> songs;
      songs = homeLocalDataSource.fetchFeaturedSongs(pageNumber: pageNumber);
      if(songs.isNotEmpty){
        return right(songs);

      }
      songs = await homeRemoteDataSource.fetchFeaturedSongs(pageNumber: pageNumber);
      return right(songs);
    } catch (e) {
      if(e is DioException){
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }

  }

  @override
  Future<Either<Failure, List<SongEntity>>> fetchAllSongs() async{
    try {
      List<SongEntity> songs;
      songs = homeLocalDataSource.fetchAllSongs();
      if(songs.isNotEmpty){
        return right(songs);
      }
      songs = await homeRemoteDataSource.fetchAllSongs();
      return right(songs);
    } catch (e) {
      if(e is DioException){
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

}