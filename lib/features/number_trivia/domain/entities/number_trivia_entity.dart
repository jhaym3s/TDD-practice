
import 'package:equatable/equatable.dart';

class NumberTriviaEntities extends Equatable{
  final String text;
  final int number;

  const NumberTriviaEntities({required this.text, required this.number});
  
  @override
  List<Object?> get props => [text, number];
  
}