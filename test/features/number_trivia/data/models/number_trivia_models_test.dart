import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:test_driven_development/feature/number_trivia/data/models/number_trivia_models.dart';
import 'package:test_driven_development/feature/number_trivia/domain/entities/number_trivia.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const  tNumberTriviaModel = NumberTriviaModel(number: 1, text: "test");

  test("NumberTriviaModel should be ethe subclass of NumberTrivia Entity", (){
    //arrnage
    //act
    //assert
    expect(tNumberTriviaModel, isA<NumberTrivia>());
  });

  group("fromJson", (){
    test("Should return json map when int", (){
      //arrange 
      Map<String, dynamic> jsonMap = jsonDecode(fixtures('trivia.json'));
      //act
      final result = NumberTriviaModel.fromJson(jsonMap);

      //assert
      expect(result, tNumberTriviaModel);
    });

    test("Should return json map when double", (){
      //arrange 
      Map<String, dynamic> jsonMap = jsonDecode(fixtures('trivia_double.json'));
      //act
      final result = NumberTriviaModel.fromJson(jsonMap);

      //assert
      expect(result, tNumberTriviaModel);
    });
  });

  group("toJson", (){
    test("should return a json map", (){
      //act
      final result = tNumberTriviaModel.toJson();
      //assert
      final expectedMap = {"text": "test",
    "number": 1,};
      expect(result, expectedMap );
    });
  });
}