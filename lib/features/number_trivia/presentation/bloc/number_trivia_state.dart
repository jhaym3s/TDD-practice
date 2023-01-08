part of 'number_trivia_bloc.dart';

abstract class NumberTriviaState extends Equatable {
  const NumberTriviaState();
  
  @override
  List<Object> get props => [];
}

class NumberTriviaInitialState extends NumberTriviaState {}

class NumberTriviaLoadingState extends NumberTriviaState {}

class NumberTriviaSuccessState extends NumberTriviaState {
  final NumberTriviaEntities numberTriviaEntities;

  const  NumberTriviaSuccessState({required this.numberTriviaEntities});
}

class NumberTriviaFailureState extends NumberTriviaState {
  final String errorMessage;

 const  NumberTriviaFailureState({required this.errorMessage});
 @override
  List<Object> get props => [errorMessage];
}

