import 'package:test_driven_development/core/errors/exceptions.dart';
import 'package:test_driven_development/core/platform/network_info.dart';
import 'package:test_driven_development/feature/number_trivia/data/datasources/number_trivia_local_data_sources.dart';
import 'package:test_driven_development/feature/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:test_driven_development/feature/number_trivia/data/models/number_trivia_models.dart';
import 'package:test_driven_development/feature/number_trivia/domain/entities/number_trivia.dart';
import 'package:test_driven_development/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:test_driven_development/feature/number_trivia/domain/repositories/number_trivia_repository.dart';

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  const NumberTriviaRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});
  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(
      int? number) async {
    return getTrivia(() => remoteDataSource.getConcreteNumberTrivia(number));
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    return getTrivia(() => remoteDataSource.getRandomNumberTrivia());
  }

  Future<Either<Failure, NumberTrivia>> getTrivia(
      Future<NumberTriviaModel> Function() getContreteOrRandom) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTrivia = await getContreteOrRandom();
        localDataSource.cacheNumberTrivia(remoteTrivia);
        return Right(remoteTrivia);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTrivia = await localDataSource.getLastNumberTrivia();
        return Right(localTrivia);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
