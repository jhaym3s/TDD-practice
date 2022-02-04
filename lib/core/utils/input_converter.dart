import 'package:dartz/dartz.dart';
import 'package:test_driven_development/core/errors/failures.dart';

class InputConverter{

  Either<Failure,int> stringToUnsignedInterger(String str){
    try{
      final number = int.parse(str);
      if(number < 0 ) throw FormatException;
  return Right(number);
    } on FormatException{
    return  Left(InvalidInputFailure());
    }
  }


}

class InvalidInputFailure extends Failure{}