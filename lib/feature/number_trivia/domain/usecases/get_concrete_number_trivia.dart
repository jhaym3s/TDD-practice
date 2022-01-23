import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:test_driven_development/core/errors/failures.dart';
import 'package:test_driven_development/core/usecases/usecase.dart';
import 'package:test_driven_development/feature/number_trivia/domain/entities/number_trivia.dart';
import 'package:test_driven_development/feature/number_trivia/domain/repositories/number_trivia_repository.dart';

class GetConcreteNumberTrivia implements Usecase<NumberTrivia, Params>{
  final NumberTriviaRepository numberTriviaRepository;

  const GetConcreteNumberTrivia(this.numberTriviaRepository);

  @override
  Future<Either<Failure, NumberTrivia>> call(Params params) async {
    return await numberTriviaRepository.getConcreteNumberTrivia(params.number);
  }
}

class Params extends Equatable{
  final int number;

  const Params({ required this.number});
  @override
  List<Object?> get props => [number];
  
}