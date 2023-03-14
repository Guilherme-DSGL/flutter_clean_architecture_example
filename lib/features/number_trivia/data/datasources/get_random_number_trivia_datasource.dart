import '../dto/number_trivia_dto.dart';

abstract class GetRandomNumberTriviaDataSource {
  ///Calls the http://numbersapi.com/ramdom endpoint.
  ///
  ///Throws a [ServerException] for all error codes.
  Future<NumberTriviaDTO> call();
}
