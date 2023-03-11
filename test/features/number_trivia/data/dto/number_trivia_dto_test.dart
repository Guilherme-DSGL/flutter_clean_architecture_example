import 'package:flutter_clean_architecture_example/features/number_trivia/data/dto/number_trivia_dto.dart';
import 'package:flutter_clean_architecture_example/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  const tNumberTriviaDTO = NumberTriviaDTO(
      number: 23.00,
      text: "1337 is the number that spells \"leet\" in leetspeak.");
  final json = {
    "text": "1337 is the number that spells \"leet\" in leetspeak.",
    "number": 23.00,
    "found": true,
    "type": "trivia"
  };
  test('should be a subclass of NumberTrivia entity', () async {
    expect(tNumberTriviaDTO, isInstanceOf<NumberTriviaEntity>());
  });

  test("Shloud return a valid model when the json is an integer", () {
    final result = NumberTriviaDTO.fromMap(json);
    expect(result, equals(tNumberTriviaDTO));
  });

  test("Shloud return a valid model when the json is an integer", () {
    final result = NumberTriviaDTO.fromMap(json);
    expect(result, equals(tNumberTriviaDTO));
  });

  group('toJson', () {
    test("Should return a json map containing the proper data", () {
      final result = tNumberTriviaDTO.toMap();
      final expectedJson = {
        'text': '1337 is the number that spells "leet" in leetspeak.',
        'number': 23.0,
      };
      expect(result, equals(expectedJson));
    });
  });
}
