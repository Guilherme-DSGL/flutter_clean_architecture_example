import 'package:flutter_clean_architecture_example/core/error/exceptions.dart';
import 'package:flutter_clean_architecture_example/features/number_trivia/data/datasources/get_last_number_trivia_datasource.dart';
import 'package:flutter_clean_architecture_example/features/number_trivia/data/datasources/local/get_last_number_trivia_local_data_source_imp.dart';
import 'package:flutter_clean_architecture_example/features/number_trivia/data/dto/number_trivia_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './get_last_number_trivia_data_source_test.mocks.dart';
import '../../../../../../fixtures/fixtures_reader.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late GetLastNumberTriviaLocalDataSource getLastNumberTriviaLocalDataSource;
  late MockSharedPreferences mockSharedPreferences;
  final tNumberTriviaDTO =
      NumberTriviaDTO.fromJson(fixture("trivia_cached.json"));
  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    getLastNumberTriviaLocalDataSource = GetLastNumberTriviaLocalDataSourceImp(
        sharedPreferences: mockSharedPreferences);
  });

  test(
      "should return number trivia from SharedPreferences whe there is one in the cache ",
      () async {
    when(mockSharedPreferences.getString(any))
        .thenReturn(fixture("trivia_cached.json"));

    final result = await getLastNumberTriviaLocalDataSource();

    verify(mockSharedPreferences.getString("CACHED_NUMBER_TRIVIA"));
    expect(result, equals(tNumberTriviaDTO));
  });

  test("should throw cache exception when there is not cached value ",
      () async {
    when(mockSharedPreferences.getString(any)).thenAnswer((_) => null);

    final call = getLastNumberTriviaLocalDataSource;

    expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
  });
}
