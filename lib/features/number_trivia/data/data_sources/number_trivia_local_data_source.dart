
import '../models/number_trivia_model.dart';

abstract class AbstractNumberTriviaLocalDataSource {
  Future<NumberTriviaModel> getLastStoredTrivia();
  Future cacheNumberTrivia(NumberTriviaModel triviaToStore);
}