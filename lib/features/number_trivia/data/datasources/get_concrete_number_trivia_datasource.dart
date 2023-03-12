import '../dto/number_trivia_dto.dart';

abstract class GetConcreteNumberTriviaDataSource {
  Future<NumberTriviaDTO> call(int number);
}
