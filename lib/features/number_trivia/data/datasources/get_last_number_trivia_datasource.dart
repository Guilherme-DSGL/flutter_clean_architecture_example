import '../../domain/entities/number_trivia.dart';

abstract class GetLastNumberTriviaLocalDataSource {
  Future<NumberTriviaEntity> call();
}
