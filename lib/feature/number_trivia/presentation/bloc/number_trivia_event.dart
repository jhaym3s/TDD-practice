part of 'number_trivia_bloc.dart';

@immutable
abstract class NumberTriviaEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class GetRandomTrivia extends NumberTriviaEvent{

}

class GetQueriedNumberTrivia extends NumberTriviaEvent{
    final String number;

    GetQueriedNumberTrivia({required this.number});

    @override
  List<Object?> get props => [number];
}

