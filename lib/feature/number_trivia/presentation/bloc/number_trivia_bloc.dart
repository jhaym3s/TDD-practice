import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:test_driven_development/core/utils/input_converter.dart';
import 'package:test_driven_development/feature/number_trivia/data/models/number_trivia_models.dart';
import 'package:test_driven_development/feature/number_trivia/domain/entities/number_trivia.dart';
import 'package:test_driven_development/feature/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:test_driven_development/feature/number_trivia/domain/usecases/get_random_number_trivia.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

const server_failure = "Server Failure";
const cached_failure = "Cached Failure";
const Invalid_Input_failure = "MUST BE >=0";


class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  GetConcreteNumberTrivia? concreteNumberTrivia;
  GetRandomNumberTrivia? randomNumberTrivia;
  InputConverter? inputConverter;
  NumberTriviaBloc(
      {required this.concreteNumberTrivia,
      required this.randomNumberTrivia,
      required this.inputConverter})
      : super(Empty()) {
    on<GetRandomTrivia>(onGetRandomTrivia);
    on<GetQueriedNumberTrivia>(onGetQueriedTrivia);
  }

  FutureOr<void> onGetRandomTrivia(GetRandomTrivia event, Emitter<NumberTriviaState> emit) {
   
  }

  FutureOr<void> onGetQueriedTrivia(GetQueriedNumberTrivia event, Emitter<NumberTriviaState> emit) {
    
       final inputEither = inputConverter!.stringToUnsignedInterger(event.number);
      // inputEither.fold((l) => ErrorState(message: Invalid_Input_failure), (trivia) => emit(LoadedState(trivia: )));
   
  }
}
