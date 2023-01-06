import '../models/number_trivia_model.dart';

abstract class AbstractNumberTriviaRemoteDataSource{

  Future<NumberTriviaModel> getConcreteNumberTrivia(int number); 
   Future<NumberTriviaModel> getRandomNumberTrivia(); 

}