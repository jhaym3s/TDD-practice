
import 'package:dartz/dartz.dart';
import 'package:test_driven_development/features/number_trivia/domain/entities/number_trivia_entity.dart';
import 'package:test_driven_development/features/number_trivia/domain/repositories/number_trivia_abstract_repository.dart';

import '../../../../core/errors/failures.dart';

class GetConcreteNumberTriviaUsecase{
  final AbstractNumberTriviaRepository abstractRepository;

  GetConcreteNumberTriviaUsecase(this.abstractRepository);

  Future<Either<Failure,NumberTriviaEntities>> call({required int number})async{
      var value = await abstractRepository.getConcreteNumberTrivia(number);
      return  value;
  }
}