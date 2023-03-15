import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_example/core/error/exceptions.dart';
import 'package:flutter_clean_architecture_example/core/error/failures.dart';
import 'package:flutter_clean_architecture_example/core/network/network_info.dart';
import 'package:flutter_clean_architecture_example/features/number_trivia/data/datasources/cache_number_trivia_datasource.dart';
import 'package:flutter_clean_architecture_example/features/number_trivia/data/datasources/get_concrete_number_trivia_datasource.dart';
import 'package:flutter_clean_architecture_example/features/number_trivia/data/datasources/get_last_number_trivia_datasource.dart';
import 'package:flutter_clean_architecture_example/features/number_trivia/data/dto/number_trivia_dto.dart';
import 'package:flutter_clean_architecture_example/features/number_trivia/data/repositories/get_concrete_number_trivia_repository_imp.dart';
import 'package:flutter_clean_architecture_example/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_clean_architecture_example/features/number_trivia/domain/repositories/get_concrete_number_trivia_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_concrete_number_trivia_repository_test.mocks.dart';

@GenerateMocks([
  NetworkInfo,
  GetConcreteNumberTriviaDataSource,
  CacheNumberTriviaDataSource,
  GetLastNumberTriviaLocalDataSource
])
void main() {
  late GetConcreteNumberTriviaRepository getConcreteNumberTriviaRepository;
  late MockGetConcreteNumberTriviaDataSource
      mockGetConcreteNumberTriviaDataSource;
  late MockGetLastNumberTriviaLocalDataSource
      mockGetLastNumberTriviaLocalDataSource;
  late MockCacheNumberTriviaDataSource mockCacheNumberTriviaDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late int tNumber;
  late NumberTriviaDTO tNumberTriviaDTO;
  late NumberTriviaEntity tNumberTriviaEntity;
  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockGetConcreteNumberTriviaDataSource =
        MockGetConcreteNumberTriviaDataSource();
    mockCacheNumberTriviaDataSource = MockCacheNumberTriviaDataSource();
    mockGetLastNumberTriviaLocalDataSource =
        MockGetLastNumberTriviaLocalDataSource();
    getConcreteNumberTriviaRepository = GetConcreteNumberTriviaRepositoryImp(
        networkInfo: mockNetworkInfo,
        getConcreteNumberTriviaDataSource:
            mockGetConcreteNumberTriviaDataSource,
        cacheNumberTriviaDataSource: mockCacheNumberTriviaDataSource,
        getLastNumberTriviaLocalDataSource:
            mockGetLastNumberTriviaLocalDataSource);
    tNumber = 1;
    tNumberTriviaDTO = NumberTriviaDTO(text: "test", number: tNumber);
    tNumberTriviaEntity = tNumberTriviaDTO;
  });

  test("Should test if the device is online", () async {
    when(mockNetworkInfo.isConected).thenAnswer((_) async => true);
    when(mockGetConcreteNumberTriviaDataSource(number: anyNamed("number")))
        .thenAnswer((_) => Future.value(tNumberTriviaDTO));
    final result = getConcreteNumberTriviaRepository(tNumber);

    verify(mockNetworkInfo.isConected);
  });

  group("device is online", () {
    setUp(() {
      when(mockNetworkInfo.isConected).thenAnswer((_) async => true);
    });

    test(
        "should return remote data when the call to remote data source is suscessful",
        () async {
      when(mockGetConcreteNumberTriviaDataSource(number: anyNamed("number")))
          .thenAnswer((_) async => tNumberTriviaDTO);

      final result = await getConcreteNumberTriviaRepository(tNumber);
      verify(mockGetConcreteNumberTriviaDataSource(number: tNumber));
      expect(result, equals(Right(tNumberTriviaEntity)));
    });

    test(
        "should cache the data locally when the call to remote data source is suscessful",
        () async {
      when(mockGetConcreteNumberTriviaDataSource(number: anyNamed("number")))
          .thenAnswer((_) async => tNumberTriviaDTO);

      final result = await getConcreteNumberTriviaRepository(tNumber);
      verify(mockGetConcreteNumberTriviaDataSource(number: tNumber));
      verify(mockCacheNumberTriviaDataSource(
          numberTriviaToCache: tNumberTriviaDTO));
      expect(result, equals(Right(tNumberTriviaEntity)));
    });

    test(
        "should return server failure when the call to remote data source is unsuscessful",
        () async {
      when(mockGetConcreteNumberTriviaDataSource(number: anyNamed("number")))
          .thenThrow(ServerException());

      final result = await getConcreteNumberTriviaRepository(tNumber);
      verify(mockGetConcreteNumberTriviaDataSource(number: tNumber));
      verifyZeroInteractions(mockCacheNumberTriviaDataSource);
      expect(result, equals(Left(ServerFailure())));
    });
  });
  group("device is offline", () {
    setUp(() {
      when(mockNetworkInfo.isConected).thenAnswer((_) async => false);
    });

    test('should return last locally cache data when the cahe data is present',
        () async {
      when(mockGetLastNumberTriviaLocalDataSource())
          .thenAnswer((_) async => tNumberTriviaDTO);

      final result = await getConcreteNumberTriviaRepository(tNumber);

      verifyZeroInteractions(mockGetConcreteNumberTriviaDataSource);
      verify(mockGetLastNumberTriviaLocalDataSource());
      expect(result, equals(Right(tNumberTriviaDTO)));
    });

    test("should return CacheFailure when there is no cache data present",
        () async {
      when(mockGetLastNumberTriviaLocalDataSource())
          .thenThrow(CacheException());

      final result = await getConcreteNumberTriviaRepository(tNumber);

      expect(result, equals(Left(CacheFailure())));
    });
  });
}
