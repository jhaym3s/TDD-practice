import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_driven_development/core/platform/network_info.dart';
import 'package:test_driven_development/feature/number_trivia/data/datasources/number_trivia_local_data_sources.dart';
import 'package:test_driven_development/feature/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:test_driven_development/feature/number_trivia/data/repositories/number_trivia_repository_impl.dart';

class MockRemoteDataSource extends Mock
    implements NumberTriviaRemoteDataSource {}

class MockLocalDataSource extends Mock implements NumberTriviaLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
   MockRemoteDataSource mockRemoteDataSource;
   MockLocalDataSource mockLocalDataSource;
   MockNetworkInfo mockNetworkInfo;
  late NumberTriviaRepositoryImpl numberTriviaRepositoryImpl;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    numberTriviaRepositoryImpl = NumberTriviaRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo
    );
  });
}