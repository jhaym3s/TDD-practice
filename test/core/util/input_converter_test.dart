import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_driven_development/core/utils/input_converter.dart';

void main() {
  
  late InputConverter inputConverter;

  setUp((){
    inputConverter = InputConverter();
  });

  group("String to unsigned group", (){

    test("Should convert an int imputed as a string to int", (){
      //arrange 
      const str =  "12";
      //act
      final result = inputConverter.stringToUnsignedInterger(str);
      //assert
      expect(result, const Right(12));
    });

    test("Should return failure when it is a string that was passed",(){
      const str = "abc";
 //act
    final result = inputConverter.stringToUnsignedInterger(str);
    //assert
    expect(result, const Left(InvalidInputFailure));
    });

     test("Should return failure when it is a string that was passed",(){
      const str = "-123";
 //act
    final result = inputConverter.stringToUnsignedInterger(str);
    //assert
    expect(result, const Right(InvalidInputFailure));
    });
  });
}