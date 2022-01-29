import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_driven_development/core/errors/exceptions.dart';
import 'package:test_driven_development/feature/number_trivia/data/models/number_trivia_models.dart';

abstract class NumberTriviaLocalDataSource {

  /// Gets the cached [NumberTriviaModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<NumberTriviaModel> getLastNumberTrivia();

  Future cacheNumberTrivia(NumberTriviaModel numberTriviaToCache);
}

const cachedNumberTrivia = 'CACHED_NUMBER_TRIVIA';
class LocalDataSourceImpl implements NumberTriviaLocalDataSource{

  final SharedPreferences sharedPreferences;

  LocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future cacheNumberTrivia(NumberTriviaModel numberTriviaToCache) {
    final jsonString = sharedPreferences.getString(cachedNumberTrivia);
    if(jsonString != null){
    final result = Future.value(NumberTriviaModel.fromJson(jsonDecode(jsonString)));
    }else{
      throw CacheException();
    }
    throw CacheException();
  }

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() {
    // TODO: implement getLastNumberTrivia
    throw UnimplementedError();
  }
  
}