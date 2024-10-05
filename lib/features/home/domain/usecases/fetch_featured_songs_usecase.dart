import 'package:musix/core/usecases/use_case.dart';
import 'package:musix/features/home/domain/repos/home_repo.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/song_entity.dart';

class FetchFeaturedSongsUseCase extends UseCase<List<SongEntity>,int>{
  final HomeRepo homeRepo;
  FetchFeaturedSongsUseCase(this.homeRepo);

  @override
  Future<Either<Failure, List<SongEntity>>> call([int param=0]) {
    return homeRepo.fetchFeaturedSongs(pageNumber: param);
  }


}