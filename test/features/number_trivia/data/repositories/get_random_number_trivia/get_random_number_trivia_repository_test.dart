import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_example/core/error/exceptions.dart';
import 'package:flutter_clean_architecture_example/core/error/failures.dart';
import 'package:flutter_clean_architecture_example/core/platform/network_info.dart';
import 'package:flutter_clean_architecture_example/features/number_trivia/data/datasources/cache_number_trivia_datasource.dart';
import 'package:flutter_clean_architecture_example/features/number_trivia/data/datasources/get_last_number_trivia_datasource.dart';
import 'package:flutter_clean_architecture_example/features/number_trivia/data/datasources/get_random_number_trivia_datasource.dart';
import 'package:flutter_clean_architecture_example/features/number_trivia/data/dto/number_trivia_dto.dart';
import 'package:flutter_clean_architecture_example/features/number_trivia/data/repositories/get_random_number_trivia_repository_imp.dart';
import 'package:flutter_clean_architecture_example/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_clean_architecture_example/features/number_trivia/domain/repositories/get_random_number_trivia_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_random_number_trivia_repository_test.mocks.dart';

@GenerateMocks([
  GetRandomNumberTriviaDataSource,
  CacheNumberTriviaDataSource,
  NetworkInfo,
  GetLastNumberTriviaLocalDataSource
])
void main() {
  late GetRandomNumberTriviaRepository getRandomNumberTriviaRepository;
  late MockGetRandomNumberTriviaDataSource mockGetRandomNumberTriviaDataSource;
  late MockCacheNumberTriviaDataSource mockCacheNumberTriviaDataSource;
  late MockGetLastNumberTriviaLocalDataSource
      mockGetLastNumberTriviaLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late int tNumber;
  late NumberTriviaDTO tNumberTriviaDTO;
  late NumberTriviaEntity tNumberTriviaEntity;
  setUp(() {
    mockGetRandomNumberTriviaDataSource = MockGetRandomNumberTriviaDataSource();
    mockNetworkInfo = MockNetworkInfo();
    mockCacheNumberTriviaDataSource = MockCacheNumberTriviaDataSource();
    mockGetLastNumberTriviaLocalDataSource =
        MockGetLastNumberTriviaLocalDataSource();
    getRandomNumberTriviaRepository = GetRandomNumberTriviaRepositoryImp(
      getLastNumberTriviaLocalDataSource:
          mockGetLastNumberTriviaLocalDataSource,
      networkInfo: mockNetworkInfo,
      getRandomNumberTriviaDataSource: mockGetRandomNumberTriviaDataSource,
      cacheNumberTriviaDataSource: mockCacheNumberTriviaDataSource,
    );
    tNumber = 1;
    tNumberTriviaDTO = NumberTriviaDTO(text: "test", number: tNumber);
    tNumberTriviaEntity = tNumberTriviaDTO;
  });

  group("Device is online", () {
    setUp(() {
      when(mockNetworkInfo.isConected).thenAnswer((_) async => true);
    });

    test(
        "Should return a NumberTriviaEntity when the call to remote data is sucessfull",
        () async {
      when(mockGetRandomNumberTriviaDataSource())
          .thenAnswer((_) async => tNumberTriviaDTO);

      final result = await getRandomNumberTriviaRepository();
      verify(mockGetRandomNumberTriviaDataSource());
      expect(result, equals(Right(tNumberTriviaEntity)));
    });

    test("should cache the data when data source is suscessful", () async {
      when(mockGetRandomNumberTriviaDataSource())
          .thenAnswer((_) async => tNumberTriviaDTO);

      final result = await getRandomNumberTriviaRepository();
      verify(mockGetRandomNumberTriviaDataSource());
      verify(mockCacheNumberTriviaDataSource(
          numberTriviaToCache: tNumberTriviaDTO));
      expect(result, equals(Right(tNumberTriviaEntity)));
    });

    test(
        "Should return a server failure when call the remote data source is unsucessful",
        () async {
      when(mockGetRandomNumberTriviaDataSource()).thenThrow(ServerException());

      final result = await getRandomNumberTriviaRepository();
      verify(mockGetRandomNumberTriviaDataSource());
      verifyZeroInteractions(mockCacheNumberTriviaDataSource);
      expect(result, equals(Left(ServerFailure())));
    });
  });

  group("Device is offline", () {
    setUp(() {
      when(mockNetworkInfo.isConected).thenAnswer((_) async => false);
    });

    test('should return last locally cache data when the cahe data is present',
        () async {
      when(mockGetLastNumberTriviaLocalDataSource())
          .thenAnswer((_) async => tNumberTriviaDTO);

      final result = await getRandomNumberTriviaRepository();

      verifyZeroInteractions(mockGetRandomNumberTriviaDataSource);
      verify(mockGetLastNumberTriviaLocalDataSource());
      expect(result, equals(Right(tNumberTriviaDTO)));
    });

    test("should return CacheFailure when there is no cache data present",
        () async {
      when(mockGetLastNumberTriviaLocalDataSource())
          .thenThrow(CacheException());

      final result = await getRandomNumberTriviaRepository();

      expect(result, equals(Left(CacheFailure())));
    });
  });
}
