import 'package:dartz/dartz.dart';
import 'package:test_driven_development/core/errors/failures.dart';
import 'package:test_driven_development/feature/number_trivia/domain/entities/number_trivia.dart';

abstract class NumberTriviaRepository {

  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int? number);

  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia();
}