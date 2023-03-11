import 'package:flutter_clean_architecture_example/core/platform/network_info.dart';
import 'package:flutter_clean_architecture_example/features/number_trivia/data/datasources/local/number_trivia_local_data_source.dart';
import 'package:flutter_clean_architecture_example/features/number_trivia/data/datasources/remote/number_trivia_remote_data_source.dart';
import 'package:flutter_clean_architecture_example/features/number_trivia/data/repositories/number_trivia_repository_imp.dart';
import 'package:flutter_clean_architecture_example/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'number_trivia_repository_test.mocks.dart';

@GenerateMocks(
    [NumberTriviaRemoteDataSource, NumberTriviaLocalDataSource, NetworkInfo])
void main() {
  late NumberTriviaRepository repository;
  late MockNumberTriviaLocalDataSource mockNumberTriviaLocalDataSource;
  late MockNumberTriviaRemoteDataSource mockNumberTriviaRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockNumberTriviaLocalDataSource = MockNumberTriviaLocalDataSource();
    mockNumberTriviaRemoteDataSource = MockNumberTriviaRemoteDataSource();
    repository = NumberTriviaRepositoryImp(
        localDataSource: mockNumberTriviaLocalDataSource,
        networkInfo: mockNetworkInfo,
        remoteDataSource: mockNumberTriviaRemoteDataSource);
  });
  group('Repositories tests', () {
    test('', () => {});
  });
}
