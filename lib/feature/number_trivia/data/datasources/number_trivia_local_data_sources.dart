import 'package:test_driven_development/feature/number_trivia/data/models/number_trivia_models.dart';

abstract class NumberTriviaLocalDataSource {

  /// Gets the cached [NumberTriviaModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<NumberTriviaModel> getLastNumberTrivia();

  Future cacheNumberTrivia(NumberTriviaModel numberTriviaToCache);
}