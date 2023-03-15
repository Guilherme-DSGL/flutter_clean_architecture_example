import 'package:flutter_clean_architecture_example/features/number_trivia/data/dto/number_trivia_dto.dart';

abstract class CacheNumberTriviaDataSource {
  void call({required NumberTriviaDTO numberTriviaToCache});
}
