import 'package:flutter_clean_architecture_example/core/platform/network_info.dart';
import 'package:flutter_clean_architecture_example/features/number_trivia/data/datasources/get_concrete_number_trivia_datasource.dart';
import 'package:flutter_clean_architecture_example/features/number_trivia/data/repositories/get_concrete_number_trivia_repository_imp.dart';
import 'package:flutter_clean_architecture_example/features/number_trivia/domain/repositories/get_concrete_number_trivia_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'get_concrete_number_trivia_repository_test.mocks.dart';

@GenerateMocks([
  GetConcreteNumberTriviaRepository,
  NetworkInfo,
  GetConcreteNumberTriviaDataSource
])
void main() {
  group("get Concrete Number trivia tests", () {
    late GetConcreteNumberTriviaRepository repository;
    late MockGetConcreteNumberTriviaRepository
        mockGetContMockGetConcreteNumberTriviaRepository;
    late MockGetConcreteNumberTriviaDataSource
        mockGetConcreteNumberTriviaDataSource;
    late MockNetworkInfo mockNetworkInfo;
    setUp(() {
      mockNetworkInfo = MockNetworkInfo();
      mockGetContMockGetConcreteNumberTriviaRepository =
          MockGetConcreteNumberTriviaRepository();
      mockGetConcreteNumberTriviaDataSource =
          MockGetConcreteNumberTriviaDataSource();
      repository = GetConcreteNumberTriviaRepositoryImp(
          networkInfo: mockNetworkInfo,
          dataSource: mockGetConcreteNumberTriviaDataSource);
    });

    test("", () {});
  });
}
