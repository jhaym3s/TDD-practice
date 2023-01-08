
import 'package:dartz/dartz.dart';

import '../errors/failures.dart';

class InputConverter{
  Either<Failure, int> stringConverter(String str){
    try {
      return  Right(int.parse(str));
    } on FormatException{
      return Left(InvalidInputFailure()); 
    }
    
  }
}

 class InvalidInputFailure extends Failure{
  @override
  List<Object?> get props => [];
 }