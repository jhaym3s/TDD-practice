
import 'package:equatable/equatable.dart';

import 'exceptions.dart';

abstract class Failure extends Equatable{
   
}


class ServerFailure extends  Failure{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class CacheFailure extends Failure{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}