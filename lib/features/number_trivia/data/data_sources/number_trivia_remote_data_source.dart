

import '../models/number_trivia_model.dart';
import 'package:http/http.dart' as http;

abstract class AbstractNumberTriviaRemoteDataSource{

  Future<NumberTriviaModel> getConcreteNumberTrivia(int number); 
   Future<NumberTriviaModel> getRandomNumberTrivia(); 

}


class NumberTriviaRemoteDataSource implements AbstractNumberTriviaRemoteDataSource{
  
  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) {
    // TODO: implement getConcreteNumberTrivia
    throw UnimplementedError();
  }

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() {
    // TODO: implement getRandomNumberTrivia
    throw UnimplementedError();
  }
}