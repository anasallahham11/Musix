import 'package:musix/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

//Generic UseCase
abstract class UseCase<Type,Param> {
  Future<Either<Failure,Type>> call([Param param]);
}

class NoParam{}