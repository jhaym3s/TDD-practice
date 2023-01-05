
import 'package:dartz/dartz.dart';
import 'package:test_driven_development/core/errors/failures.dart';


//since all usecases have one structure we create an abstract class for usecases

abstract class AbstractUseCase<Type , Params>{

 Future<Either<Failure,Type>> call(Params params); 
}