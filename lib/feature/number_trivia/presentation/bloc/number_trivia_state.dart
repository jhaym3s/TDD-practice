part of 'number_trivia_bloc.dart';

@immutable
abstract class NumberTriviaState extends Equatable{}

class Empty extends NumberTriviaState {
  @override
  
  List<Object?> get props => [];
}

class LoadingState extends NumberTriviaState {
  @override
  
  List<Object?> get props => [];
}
 class LoadedState extends NumberTriviaState {
  final NumberTrivia trivia;

  LoadedState({ required this.trivia});
  @override
  List<Object?> get props => [trivia];
}

class ErrorState extends NumberTriviaState {
  final String message;

  ErrorState({required this.message});
  @override
  List<Object?> get props => [message];
}


