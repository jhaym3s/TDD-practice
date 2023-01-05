
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:test_driven_development/core/abstract_usecase/abstract_usecase.dart';
import 'package:test_driven_development/features/number_trivia/domain/entities/number_trivia_entity.dart';
import 'package:test_driven_development/features/number_trivia/domain/repositories/number_trivia_abstract_repository.dart';

import '../../../../core/errors/failures.dart';

class GetConcreteNumberTriviaUseCase implements AbstractUseCase<NumberTriviaEntities,Params>{
  final AbstractNumberTriviaRepository abstractRepository;

  GetConcreteNumberTriviaUseCase(this.abstractRepository);

  // Future<Either<Failure,NumberTriviaEntities>> execute({required int number})async{
  //     var value = await abstractRepository.getConcreteNumberTrivia(number);
  //     return  value;
  // }
  
  @override
  Future<Either<Failure, NumberTriviaEntities>> call(Params params) async{
    return await abstractRepository.getConcreteNumberTrivia(params.concreteNumber);
  }

}

    class Params extends Equatable{
      final int concreteNumber;

  const Params({required this.concreteNumber});
      

      @override
      List<Object?> get props => throw UnimplementedError();
      
    }