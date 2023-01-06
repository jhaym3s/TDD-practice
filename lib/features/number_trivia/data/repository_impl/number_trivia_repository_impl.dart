
import 'package:test_driven_development/core/errors/exceptions.dart';
import 'package:test_driven_development/core/platform/network_info.dart';
import 'package:test_driven_development/features/number_trivia/data/data_sources/number_trivia_local_data_source.dart';
import 'package:test_driven_development/features/number_trivia/data/data_sources/number_trivia_remote_data_source.dart';
import 'package:test_driven_development/features/number_trivia/domain/entities/number_trivia_entity.dart';
import 'package:test_driven_development/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:test_driven_development/features/number_trivia/domain/repositories/number_trivia_abstract_repository.dart';
 typedef Future<NumberTriviaEntities> _ConcreteOrRandom();
class NumberTriviaRepositoryImpl implements AbstractNumberTriviaRepository{
  AbstractNumberTriviaRemoteDataSource abstractNumberTriviaRemoteDataSource;
  AbstractNumberTriviaLocalDataSource abstractNumberTriviaLocalDataSource;
  NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl({required this.abstractNumberTriviaLocalDataSource, required this.abstractNumberTriviaRemoteDataSource, required this.networkInfo});
  @override
  Future<Either<Failure, NumberTriviaEntities>> getConcreteNumberTrivia(int number) async{
      return await _getTrivia(() {
    return abstractNumberTriviaRemoteDataSource.getRandomNumberTrivia();
   });
  }

  @override
  Future<Either<Failure, NumberTriviaEntities>> getRandomNumberTrivia() async{
   return await _getTrivia(() {
    return abstractNumberTriviaRemoteDataSource.getRandomNumberTrivia();
   });
  }


Future<Either<Failure, NumberTriviaEntities>> _getTrivia(
  _ConcreteOrRandom randomOrConcreteTrivia
)async{
    if (await networkInfo.isConnected) {
       try {
       final remoteTrivia = await  abstractNumberTriviaRemoteDataSource.getRandomNumberTrivia();
    abstractNumberTriviaLocalDataSource.cacheNumberTrivia(remoteTrivia); 
    return Right(remoteTrivia); 
    } on ServerException{
     return Left(ServerFailure());  
      }
    }else{
      try {
        final localTrivia = await abstractNumberTriviaLocalDataSource.getLastStoredTrivia();
      return Right(localTrivia);
      }on CacheException {
        return Left(CacheFailure());
      }
      
    }}
  }