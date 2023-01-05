

import 'package:dartz/dartz.dart';
import 'package:test_driven_development/core/abstract_usecase/abstract_usecase.dart';
import 'package:test_driven_development/core/errors/failures.dart';
import 'package:test_driven_development/features/number_trivia/domain/entities/number_trivia_entity.dart';
import 'package:test_driven_development/features/number_trivia/domain/repositories/number_trivia_abstract_repository.dart';

class GetRandomNumberTriviaUseCase implements AbstractUseCase<NumberTriviaEntities, NoParams>{
  final AbstractNumberTriviaRepository abstractRepository;

  GetRandomNumberTriviaUseCase(this.abstractRepository);
  @override
  Future<Either<Failure, NumberTriviaEntities>> call(NoParams params) async{
    return await abstractRepository.getRandomNumberTrivia();
  }
  
}


class NoParams {}