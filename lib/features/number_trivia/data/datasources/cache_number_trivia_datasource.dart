import 'package:flutter_clean_architecture_example/features/number_trivia/domain/entities/number_trivia.dart';

abstract class CacheNumberTriviaDataSource {
  void call({required NumberTriviaEntity numberTriviaToCache});
}
