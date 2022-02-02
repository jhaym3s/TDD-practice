

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_driven_development/core/errors/exceptions.dart';
import 'package:test_driven_development/feature/number_trivia/data/datasources/number_trivia_local_data_sources.dart';
import 'package:test_driven_development/feature/number_trivia/data/models/number_trivia_models.dart';
import 'package:test_driven_development/feature/number_trivia/domain/entities/number_trivia.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences{}

void main() {
  late LocalDataSourceImpl localDataSourceImpl;
  late MockSharedPreferences mockSharedPreferences;

  setUp((){
    mockSharedPreferences = MockSharedPreferences();
    localDataSourceImpl = LocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });
  group('last cached number trivia', (){
    final tNumberTriviaModel = NumberTriviaModel.fromJson(json.decode(fixtures('trivia_cached.json')));
      test("Should return last cached number if any", () async* {
        //arrange
        when(mockSharedPreferences.getString("test")).thenReturn(fixtures('trivia_cached.json'));
        //act
        final result = await localDataSourceImpl.getLastNumberTrivia();
        //accert
        verify(mockSharedPreferences.getString(cachedNumberTrivia));
         expect(result, equals(tNumberTriviaModel));
            });

            test("Should throw cashed exception if nothing was catched", () async* {
        //arrange
        when(mockSharedPreferences.getString("test")).thenReturn(null);
        //act
        final result = await localDataSourceImpl.getLastNumberTrivia();
        //accert
        verify(mockSharedPreferences.getString(cachedNumberTrivia));
         expect(result, throwsA(const TypeMatcher<CacheException>()));
         
            });
  });

  group("Cached Number Trivia", (){
      test("", (){
        
      });
  });
}