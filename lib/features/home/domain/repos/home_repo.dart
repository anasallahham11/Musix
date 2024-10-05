import 'package:musix/core/errors/failure.dart';
import 'package:musix/features/home/domain/entities/song_entity.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepo {
  Future<Either<Failure,List<SongEntity>>> fetchFeaturedSongs({int pageNumber=0});
  Future<Either<Failure,List<SongEntity>>> fetchAllSongs();
}