import '../../dto/number_trivia_dto.dart';

abstract class NumberTriviaRemoteDataSource {
  ///Calls the http://numbersapi.com/{number} endpoint.
  ///
  ///Throws a [ServerException] for all error codes.
  Future<NumberTriviaDTO> getConcreteNumberTrivia(int number);

  ///Calls the http://numbersapi.com/ramdom endpoint.
  ///
  ///Throws a [ServerException] for all error codes.
  Future<NumberTriviaDTO> getRandomNumberTrivia();
}
