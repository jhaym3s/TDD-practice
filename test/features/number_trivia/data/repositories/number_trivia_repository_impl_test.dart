import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_driven_development/core/errors/exceptions.dart';
import 'package:test_driven_development/core/errors/failures.dart';
import 'package:test_driven_development/core/platform/network_info.dart';
import 'package:test_driven_development/feature/number_trivia/data/datasources/number_trivia_local_data_sources.dart';
import 'package:test_driven_development/feature/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:test_driven_development/feature/number_trivia/data/models/number_trivia_models.dart';
import 'package:test_driven_development/feature/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:test_driven_development/feature/number_trivia/domain/entities/number_trivia.dart';

class MockRemoteDataSource extends Mock
    implements NumberTriviaRemoteDataSource {}

class MockLocalDataSource extends Mock implements NumberTriviaLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late NumberTriviaRepositoryImpl numberTriviaRepositoryImpl;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    numberTriviaRepositoryImpl = NumberTriviaRepositoryImpl(
       remoteDataSource: mockRemoteDataSource,
        localDataSource: mockLocalDataSource,
        networkInfo: mockNetworkInfo);
  });
  void runTestOnline(Function  body){
      group("device is online", () {
      setUp(() async* {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
  });
  }

   void runTestOffline(Function  body){
      group("device is offline", () {
      setUp(() async* {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
  });
  }

  group("GetConcreteNumberTrivia", () {
    const tNumber = 2;
    const tNumberTriviaModel = NumberTriviaModel(number: tNumber, text: "Test");
    const NumberTrivia tNumberTrivia = tNumberTriviaModel;
    test("check if the device is online", () async* {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      //act
      final result =
          await numberTriviaRepositoryImpl.getConcreteNumberTrivia(tNumber);
      //assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestOnline(() {
      test("should return remote data when call to remote source is successful",
          () async*{
        //arrange
        when(mockRemoteDataSource.getConcreteNumberTrivia(any))
            .thenAnswer((_) async => tNumberTriviaModel);
        //act
        final result = await numberTriviaRepositoryImpl.getConcreteNumberTrivia(tNumber);                //final result = numberTriviaRepositoryImpl.getConcreteNumberTrivia(tNumber);
        //assert
        verify(mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
        expect(result,  equals(const Right(tNumberTrivia)));
      });
      test("should cache remote data locally when call to remote source is successful",
          () async*{
        //arrange
        when(mockRemoteDataSource.getConcreteNumberTrivia(any))
            .thenAnswer((_) async => tNumberTriviaModel);
        //act
         await numberTriviaRepositoryImpl.getConcreteNumberTrivia(tNumber);                
         //final result = numberTriviaRepositoryImpl.getConcreteNumberTrivia(tNumber);
        //assert
        verify(mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
        verify(mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel));
      });

      test("should return ServerException when call to remote source is unsuccessful",
          () async* {
        //arrange
        when(mockRemoteDataSource.getConcreteNumberTrivia(any))
            .thenThrow(ServerException());
        //act
        final result = await numberTriviaRepositoryImpl.getConcreteNumberTrivia(tNumber);                //final result = numberTriviaRepositoryImpl.getConcreteNumberTrivia(tNumber);
        //assert
        verify(mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
        verifyZeroInteractions(mockLocalDataSource);
        expect(result,  equals( Left(ServerFailure())));
      });
    });

    // test for device being offline
    runTestOffline(() {
      
      test("should return last locally catched data when offline and catched data is present", () async*{
        //arrange
        when(mockLocalDataSource.getLastNumberTrivia()).thenAnswer((_) async => tNumberTriviaModel);

        //act 
        final result = numberTriviaRepositoryImpl.getConcreteNumberTrivia(tNumber);

        //assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastNumberTrivia());
        expect(result, equals(const Right(tNumberTriviaModel)));
      });

      test("should return CacheException when offline and catched data is not present", () async*{
        //arrange
        when(mockLocalDataSource.getLastNumberTrivia()).thenThrow(CacheException());

        //act 
        final result = numberTriviaRepositoryImpl.getConcreteNumberTrivia(tNumber);

        //assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastNumberTrivia());
        expect(result, equals( Left(CacheFailure())));
      });
    });
  });


  group("GetRandomNumberTrivia", () {
    const tNumber = 2;
    const tNumberTriviaModel = NumberTriviaModel(number: tNumber, text: "Test");
    const NumberTrivia tNumberTrivia = tNumberTriviaModel;
    test("check if the device is online", () async* {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      //act
      final result =
          await numberTriviaRepositoryImpl.getRandomNumberTrivia();
      //assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestOnline(() {
      test("should return remote data when call to remote source is successful",
          () async*{
        //arrange
        when(mockRemoteDataSource.getRandomNumberTrivia())
            .thenAnswer((_) async => tNumberTriviaModel);
        //act
        final result = await numberTriviaRepositoryImpl.getRandomNumberTrivia();                //final result = numberTriviaRepositoryImpl.getConcreteNumberTrivia(tNumber);
        //assert
        verify(mockRemoteDataSource.getRandomNumberTrivia());
        expect(result,  equals(const Right(tNumberTrivia)));
      });
      test("should cache remote data locally when call to remote source is successful",
          () async*{
        //arrange
        when(mockRemoteDataSource.getRandomNumberTrivia())
            .thenAnswer((_) async => tNumberTriviaModel);
        //act
         await numberTriviaRepositoryImpl.getRandomNumberTrivia();                
         //final result = numberTriviaRepositoryImpl.getConcreteNumberTrivia(tNumber);
        //assert
        verify(mockRemoteDataSource.getRandomNumberTrivia());
        verify(mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel));
      });

      test("should return ServerException when call to remote source is unsuccessful",
          () async* {
        //arrange
        when(mockRemoteDataSource.getRandomNumberTrivia())
            .thenThrow(ServerException());
        //act
        final result = await numberTriviaRepositoryImpl.getRandomNumberTrivia();                //final result = numberTriviaRepositoryImpl.getConcreteNumberTrivia(tNumber);
        //assert
        verify(mockRemoteDataSource.getRandomNumberTrivia());
        verifyZeroInteractions(mockLocalDataSource);
        expect(result,  equals( Left(ServerFailure())));
      });
    });

    // test for device being offline
    runTestOffline(() {
      
      test("should return last locally catched data when offline and catched data is present", () async*{
        //arrange
        when(mockLocalDataSource.getLastNumberTrivia()).thenAnswer((_) async => tNumberTriviaModel);

        //act 
        final result = numberTriviaRepositoryImpl.getRandomNumberTrivia();

        //assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastNumberTrivia());
        expect(result, equals(const Right(tNumberTriviaModel)));
      });

      test("should return CacheException when offline and catched data is not present", () async*{
        //arrange
        when(mockLocalDataSource.getLastNumberTrivia()).thenThrow(CacheException());

        //act 
        final result = numberTriviaRepositoryImpl.getRandomNumberTrivia();

        //assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastNumberTrivia());
        expect(result, equals( Left(CacheFailure())));
      });
    });
  });
}
