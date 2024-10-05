import 'package:musix/core/errors/failure.dart';
import 'package:musix/core/usecases/use_case.dart';
import 'package:musix/features/home/domain/entities/song_entity.dart';
import 'package:musix/features/home/domain/repos/home_repo.dart';
import 'package:dartz/dartz.dart';

class FetchAllSongsUseCase extends UseCase<List<SongEntity>,int>{
  final HomeRepo homeRepo;
  FetchAllSongsUseCase(this.homeRepo);

  @override
  Future<Either<Failure, List<SongEntity>>> call([int param=0]) {
    return homeRepo.fetchAllSongs();
  }
}