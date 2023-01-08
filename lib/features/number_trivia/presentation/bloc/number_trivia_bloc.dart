import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:test_driven_development/core/utils/input_converter.dart';
import 'package:test_driven_development/features/number_trivia/domain/entities/number_trivia_entity.dart';
import 'package:test_driven_development/features/number_trivia/domain/usecases/get_concrete_number_trivia_usecase.dart';
import 'package:test_driven_development/features/number_trivia/domain/usecases/get_random_number_usecase.dart';

import '../../../../core/errors/failures.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetRandomNumberTriviaUseCase randomNumberTriviaUseCase;
  final GetConcreteNumberTriviaUseCase concreteNumberTriviaUseCase;
  final InputConverter inputConverter;
  NumberTriviaBloc({
  required this.randomNumberTriviaUseCase, 
  required this.concreteNumberTriviaUseCase, 
  required this.inputConverter}) : super(NumberTriviaInitialState()) {
    on<GetConcreteNumberTriviaEvent>(getConcreteNumber);
    on<GetRandomNumberTriviaEvent>(getRandomTrivia);
  }

  FutureOr<void> getConcreteNumber(GetConcreteNumberTriviaEvent event, Emitter<NumberTriviaState> emit) async{
    final inputEither = inputConverter.stringConverter(event.numberString);
    inputEither.fold(
      (l) => emit (const NumberTriviaFailureState(errorMessage: "")), 
      (r) async { 
        emit (NumberTriviaLoadingState());
        final failureOrTrivia = await concreteNumberTriviaUseCase.call(Params(concreteNumber: r));
        failureOrTrivia.fold(
          (failure) => errorToReturn(failure),  
        (numberTriviaEntity) => emit(NumberTriviaSuccessState(numberTriviaEntities: numberTriviaEntity)));
  });}

    
  

  FutureOr<void> getRandomTrivia(GetRandomNumberTriviaEvent event, Emitter<NumberTriviaState> emit) async{
      final triviaOrFailure = await randomNumberTriviaUseCase(NoParams());
      triviaOrFailure.fold(
        (l) => emit(NumberTriviaFailureState(errorMessage: errorToReturn(l))),
         (numberTriviaEntity) {
            emit (NumberTriviaLoadingState());
            emit(NumberTriviaSuccessState(numberTriviaEntities: numberTriviaEntity));
         });
  }
}

    String errorToReturn(Failure failure){
        switch (failure.runtimeType) {
      case ServerFailure:
        return "Server Error";
      case CacheFailure:
        return "Cache Error";
      default:
        return "Unexpected Error";
    }
    }

  


