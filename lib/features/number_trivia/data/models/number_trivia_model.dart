
import 'package:test_driven_development/features/number_trivia/domain/entities/number_trivia_entity.dart';

class NumberTriviaModel extends NumberTriviaEntities{
  const NumberTriviaModel({required String text, required int number}) 
  : super(text: text, number: number);

  factory NumberTriviaModel.fromJson(Map<String, dynamic> json){
    return NumberTriviaModel(text: json["text"], number: (json["number"] as num ).toInt() );
  }

  Map<String,dynamic> toJson(){
    return {
      "text": text,
      "number":number,
    };
  }
}