import '../../dto/number_trivia_dto.dart';

abstract class NumberTriviaLocalDataSource {
  /// Gets the cached [NumberTriviaDTO] which was gotten the last time
  /// the user had an internet connection
  ///
  /// Throws [NoLocalDataException] if no cached date is available
  Future<NumberTriviaDTO> getLastNumberTrivia();
  Future<void> cacheNumberTrivia(NumberTriviaDTO triviaToCache);
}
