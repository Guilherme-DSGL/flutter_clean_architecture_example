import 'dart:convert';

import 'package:flutter_clean_architecture_example/features/number_trivia/data/datasources/cache_number_trivia_datasource.dart';
import 'package:flutter_clean_architecture_example/features/number_trivia/data/datasources/local/cache_number_trivia_local_data_source_imp.dart';
import 'package:flutter_clean_architecture_example/features/number_trivia/data/datasources/local/get_last_number_trivia_local_data_source_imp.dart';
import 'package:flutter_clean_architecture_example/features/number_trivia/data/dto/number_trivia_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../fixtures/fixtures_reader.dart';
import '../get_last_number_trivia_datasource/get_last_number_trivia_data_source_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late MockSharedPreferences mockSharedPreferences;
  late CacheNumberTriviaDataSource cacheNumberTriviaDataSource;
  final numberTriviaToCache = fixture("trivia_cached.json");
  final tNumberTriviaDTO = NumberTriviaDTO.fromJson(numberTriviaToCache);
  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    cacheNumberTriviaDataSource = CacheNumberTriviaLocalDataSourceImp(
        sharedPreferences: mockSharedPreferences);
  });

  test('Should call the shared preferences', () async {
    final jsonExpected = json.encode(tNumberTriviaDTO.toJson());
    when(mockSharedPreferences.setString(kcacheNumberTrivia, jsonExpected))
        .thenAnswer((realInvocation) => Future.value(true));

    cacheNumberTriviaDataSource(numberTriviaToCache: tNumberTriviaDTO);

    verify(mockSharedPreferences.setString(kcacheNumberTrivia, jsonExpected));
  });
}
