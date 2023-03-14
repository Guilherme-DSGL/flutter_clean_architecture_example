import '../dto/number_trivia_dto.dart';

abstract class GetConcreteNumberTriviaDataSource {
  ///Calls the http://numbersapi.com/{number} endpoint.
  ///
  ///Throws a [ServerException] for all error codes.
  Future<NumberTriviaDTO> call({required int number});
}
