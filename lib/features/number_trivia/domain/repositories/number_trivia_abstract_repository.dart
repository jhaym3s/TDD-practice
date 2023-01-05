
import 'package:dartz/dartz.dart';
import 'package:test_driven_development/core/errors/failures.dart';
import 'package:test_driven_development/features/number_trivia/domain/entities/number_trivia_entity.dart';

abstract class AbstractNumberTriviaRepository {

  Future<Either<Failure, NumberTriviaEntities>> getConcreteNumberTrivia(int number); 
   Future<Either<Failure, NumberTriviaEntities>> getRandomNumberTrivia(); 

}