

import '../models/number_trivia_model.dart';

abstract class AbstractNumberTriviaLocalDataSource {
  Future<NumberTriviaModel> getLastStoredTrivia();
  Future cacheNumberTrivia(NumberTriviaModel triviaToStore);
}

class NumberTriviaLocalDataSourceImpl implements AbstractNumberTriviaLocalDataSource{
  //final SharedPreference sharedPreference;
 //NumberTriviaLocalDataSourceImpl({required this.sharedPreference});
  @override
  Future cacheNumberTrivia(NumberTriviaModel triviaToStore) {
    // TODO: implement cacheNumberTrivia
    throw UnimplementedError();
  }

  @override
  Future<NumberTriviaModel> getLastStoredTrivia() {
    // TODO: implement getLastStoredTrivia
    throw UnimplementedError();
  }
}