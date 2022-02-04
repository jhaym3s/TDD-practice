import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:test_driven_development/core/errors/exceptions.dart';
import 'package:test_driven_development/feature/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:test_driven_development/feature/number_trivia/data/models/number_trivia_models.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late NumberTriviaRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    dataSource = NumberTriviaRemoteDataSourceImpl(client: mockHttpClient);
    mockHttpClient = MockHttpClient();
  });

  group("getConcreteNumberTrivia", () {
    const tNumber = 1;
    final tNumberTriviaModel = NumberTriviaModel.fromJson(json.decode(fixtures('trivia.json')));
    test(
        "should perform GET request on a URL with number being the endpoint and application/json header",
        () {
      when(mockHttpClient.get(Uri.parse("http://numbersapi.com/$tNumber"),
              headers: anyNamed("headers")))
          .thenAnswer((realInvocation) async =>
              http.Response(fixtures('trivia.json'), 200));

      dataSource.getConcreteNumberTrivia(tNumber);

      verify(mockHttpClient.get(
          Uri.parse(
            "http://numbersapi.com/$tNumber",
          ),
          headers: {'Content-Type': 'application/json'}));
    });

    test("should return numbertrivia when the reponse code is successful", ()async{
      when(mockHttpClient.get(Uri.parse("http://numbersapi.com/$tNumber"),
              headers: anyNamed("headers")))
          .thenAnswer((realInvocation) async =>
              http.Response(fixtures('trivia.json'), 200));

      final result = await dataSource.getConcreteNumberTrivia(tNumber);

      expect(result, tNumberTriviaModel);
    });

    test("throw server error when needed", () async {
        when(mockHttpClient.get(Uri.parse("http://numbersapi.com/$tNumber"),
              headers: anyNamed("headers")))
          .thenAnswer((realInvocation) async =>
              http.Response("Something went wrong", 404));

              final result = await dataSource.getConcreteNumberTrivia;

              expect(()=> result(tNumber), throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
