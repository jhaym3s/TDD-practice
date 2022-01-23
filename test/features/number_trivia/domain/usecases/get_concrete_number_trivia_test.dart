import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:test_driven_development/feature/number_trivia/domain/entities/number_trivia.dart';
import 'package:test_driven_development/feature/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_driven_development/feature/number_trivia/domain/usecases/get_concrete_number_trivia.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

void main() {
  late GetConcreteNumberTrivia usecase;
  late MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetConcreteNumberTrivia(mockNumberTriviaRepository);
  });
  const tNumber = 1;
  const tNumberTrivia = NumberTrivia(number: tNumber, text: "test");
  test("Get trivia for a certain number from repository", () async* {
    //arrange
    when(mockNumberTriviaRepository.getConcreteNumberTrivia(any))
        .thenAnswer((_) async => const Right(tNumberTrivia));

    //act
    final result = usecase(const Params(number: tNumber));

    //assert
    expect(result, const Right(tNumberTrivia));
    verify(mockNumberTriviaRepository.getConcreteNumberTrivia(20));
    verifyNoMoreInteractions(mockNumberTriviaRepository);

  });
}
