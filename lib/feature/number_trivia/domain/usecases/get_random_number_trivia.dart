import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:test_driven_development/core/errors/failures.dart';
import 'package:test_driven_development/core/usecases/usecase.dart';
import 'package:test_driven_development/feature/number_trivia/domain/entities/number_trivia.dart';
import 'package:test_driven_development/feature/number_trivia/domain/repositories/number_trivia_repository.dart';

class GetRandomNumberTrivia implements Usecase<NumberTrivia, NoParams>{

  final NumberTriviaRepository numberTriviaRepository;

  const GetRandomNumberTrivia(this.numberTriviaRepository);

  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams params) async {
    return await numberTriviaRepository.getRandomNumberTrivia();
  }
}

