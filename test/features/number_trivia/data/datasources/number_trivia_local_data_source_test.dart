

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_driven_development/feature/number_trivia/data/datasources/number_trivia_local_data_sources.dart';

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
      test("Should return last cached number if any", () async {
        //arrange
        when(mockSharedPreferences.getString('')).thenReturn(fixtures('trivia_cached.json'));
        //act
        final result = await localDataSourceImpl.getLastNumberTrivia();
        //arrange 
         
      });
  });
}