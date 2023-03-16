import '../dto/number_trivia_dto.dart';

abstract class CacheNumberTriviaDataSource {
  void call({required NumberTriviaDTO numberTriviaToCache});
}
