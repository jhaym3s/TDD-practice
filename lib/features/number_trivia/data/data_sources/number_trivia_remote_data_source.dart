

import 'dart:convert';

import 'package:test_driven_development/core/errors/exceptions.dart';

import '../models/number_trivia_model.dart';
import 'package:http/http.dart' as http;

abstract class AbstractNumberTriviaRemoteDataSource{

  Future<NumberTriviaModel> getConcreteNumberTrivia(int number); 
   Future<NumberTriviaModel> getRandomNumberTrivia(); 

}


class NumberTriviaRemoteDataSource implements AbstractNumberTriviaRemoteDataSource{
  final  http.Client client;

  NumberTriviaRemoteDataSource({required this.client});
  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) async {
   return  _getTriviaFromURL("http://numbersapi.com/$number");
  }

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() {
    return _getTriviaFromURL("http://numbersapi.com/random");
  }

  Future<NumberTriviaModel> _getTriviaFromURL(String url) async{
    var uri = Uri.parse(url);
    final response = await client.get(uri,headers: {"Content-type": "application/json"});
    if (response.body == 200) {
       return NumberTriviaModel.fromJson(jsonDecode(response.body));
    }else{
      throw ServerException();
    }
  
   
  }

}