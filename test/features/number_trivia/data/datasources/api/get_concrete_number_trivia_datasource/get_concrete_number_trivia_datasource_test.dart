import 'package:flutter_clean_architecture_example/core/error/exceptions.dart';
import 'package:flutter_clean_architecture_example/core/network/http_client/http_client.dart';
import 'package:flutter_clean_architecture_example/features/number_trivia/data/datasources/api/get_concrete_number_trivia_api_datasource_imp.dart';
import 'package:flutter_clean_architecture_example/features/number_trivia/data/datasources/get_concrete_number_trivia_datasource.dart';
import 'package:flutter_clean_architecture_example/features/number_trivia/data/dto/number_trivia_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../../../fixtures/fixtures_reader.dart';
import 'get_concrete_number_trivia_datasource_test.mocks.dart';

@GenerateMocks([HttpClientAdapter])
void main() {
  late GetConcreteNumberTriviaDataSource getConcreteNumberTriviaDataSource;
  late MockHttpClientAdapter mockHttpClient;
  const tNumberTrivia = 1;
  final tNumberTriviaDTO = NumberTriviaDTO.fromJson(fixture('trivia.json'));
  final headers = {'Content-Type': 'application/json'};
  setUp(() {
    mockHttpClient = MockHttpClientAdapter();
    getConcreteNumberTriviaDataSource =
        GetConcreteNumberTriviaApiDataSourceImp(mockHttpClient);
  });

  test("should call the get http method", () {
    when(mockHttpClient.get(any, headers: anyNamed("headers")))
        .thenAnswer((_) async => http.Response(fixture('trivia.json'), 200));

    final result = getConcreteNumberTriviaDataSource(number: tNumberTrivia);
    verify(mockHttpClient.get("$kApiUrl/$tNumberTrivia", headers: headers));
  });

  test("Should return a Number Trvia DTO when the response is 200", () async {
    when(mockHttpClient.get(any, headers: anyNamed("headers")))
        .thenAnswer((_) async => http.Response(fixture('trivia.json'), 200));

    final result =
        await getConcreteNumberTriviaDataSource(number: tNumberTrivia);

    expect(result, equals(tNumberTriviaDTO));
  });

  test(
      "Should return a Server Exception when the response code is 404 or otther",
      () async {
    when(mockHttpClient.get(any, headers: anyNamed("headers")))
        .thenAnswer((_) async => http.Response("Something went wrong", 404));

    final call = getConcreteNumberTriviaDataSource;

    expect(() => call(number: tNumberTrivia),
        throwsA(const TypeMatcher<ServerException>()));
  });
}
