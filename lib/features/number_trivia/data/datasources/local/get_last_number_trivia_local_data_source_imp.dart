import '../../../domain/entities/number_trivia.dart';
import '../../dto/number_trivia_dto.dart';
import '../get_last_number_trivia_datasource.dart';

class GetLastNumberTriviaLocalDataSourceImp
    implements GetLastNumberTriviaLocalDataSource {
  @override
  Future<NumberTriviaEntity> call() async {
    return const NumberTriviaDTO(number: 12, text: "sad");
  }
}
