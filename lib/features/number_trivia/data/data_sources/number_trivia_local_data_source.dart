

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_driven_development/core/errors/exceptions.dart';

import '../models/number_trivia_model.dart';

 const cachedKey = "CACHED_PREF_KEY";
abstract class AbstractNumberTriviaLocalDataSource {
  Future<NumberTriviaModel> getLastStoredTrivia();
  Future cacheNumberTrivia(NumberTriviaModel triviaToStore);
}

class NumberTriviaLocalDataSourceImpl implements AbstractNumberTriviaLocalDataSource{
 final SharedPreferences sharedPreferences;

  NumberTriviaLocalDataSourceImpl({required this.sharedPreferences});
 
  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache) {

    final jsonString = sharedPreferences.setString(cachedKey, json.encode(triviaToCache.toJson()));
    return jsonString;
  }

  @override
  Future<NumberTriviaModel> getLastStoredTrivia() {
      final  jsonString  = sharedPreferences.getString(cachedKey);
      if (jsonString != null){
             return Future.value(NumberTriviaModel.fromJson(jsonDecode(jsonString)));
      }else{
        throw CacheException();  
      }
  }
}