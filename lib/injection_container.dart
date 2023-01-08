import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_driven_development/core/platform/network_info.dart';
import 'package:test_driven_development/core/utils/input_converter.dart';
import 'package:test_driven_development/features/number_trivia/data/data_sources/number_trivia_local_data_source.dart';
import 'package:test_driven_development/features/number_trivia/data/data_sources/number_trivia_remote_data_source.dart';
import 'package:test_driven_development/features/number_trivia/data/repository_impl/number_trivia_repository_impl.dart';
import 'package:test_driven_development/features/number_trivia/domain/repositories/number_trivia_abstract_repository.dart';
import 'package:test_driven_development/features/number_trivia/domain/usecases/get_concrete_number_trivia_usecase.dart';
import 'package:test_driven_development/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async{
//! Features
  initFeatures();
  initCore();
}

void initFeatures() async{
  sl.registerFactory(() => NumberTriviaBloc(
      randomNumberTriviaUseCase: sl(),
      concreteNumberTriviaUseCase: sl(),
      inputConverter: sl()));
       sl.registerSingleton(() => InputConverter());
  sl.registerSingleton(() => GetConcreteNumberTriviaUseCase(sl()));
  sl.registerLazySingleton<AbstractNumberTriviaRepository >(() => NumberTriviaRepositoryImpl(
      abstractNumberTriviaLocalDataSource: sl(),
      abstractNumberTriviaRemoteDataSource: sl(),
      networkInfo: sl(),));
  sl.registerLazySingleton<AbstractNumberTriviaRemoteDataSource>(()=> NumberTriviaRemoteDataSource(client: sl()));
  sl.registerLazySingleton<AbstractNumberTriviaLocalDataSource>(()=> NumberTriviaLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

    final sharedPreferences = await SharedPreferences.getInstance();
    sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

    sl.registerLazySingleton(() => http.Client());
    sl.registerLazySingleton(() => InternetConnectionChecker());


  //sl.registerLazySingletonAsync<SharedPreferences>(() async => await SharedPreferences.getInstance());
}


void initCore() {
  sl.registerSingleton(() => InputConverter());
}

 void initExternals(){
  sl.registerSingleton(()=> null );
 }

 ///factory always gives a new instance on every call 
  ///For instance initiating NumberTriviaBloc with factory 
  /// always returns a new instance of NumberTriviaBloc


  ///registering singletons means GetIt caches an instance after the first time.
  ///Lazy singleton is cached when it is called while normal singletons are called when the app starts