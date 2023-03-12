import '../dto/number_trivia_dto.dart';

abstract class GetRandomNumberTriviaDataSource {
  Future<NumberTriviaDTO> call(int number);
}
