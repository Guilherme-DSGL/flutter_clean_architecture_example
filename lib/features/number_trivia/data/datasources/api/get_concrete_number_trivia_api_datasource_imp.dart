import '../../../../../core/error/exceptions.dart';
import '../../../../../core/network/http_client/http_client.dart';
import '../../dto/number_trivia_dto.dart';
import '../get_concrete_number_trivia_datasource.dart';

class GetConcreteNumberTriviaApiDataSourceImp
    implements GetConcreteNumberTriviaDataSource {
  final HttpClientAdapter httpClientAdapter;
  GetConcreteNumberTriviaApiDataSourceImp(this.httpClientAdapter);

  @override
  Future<NumberTriviaDTO> call({required int number}) async {
    final url = "$kApiUrl/$number";
    final response = await httpClientAdapter
        .get(url, headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      return NumberTriviaDTO.fromJson(response.body);
    } else {
      throw ServerException();
    }
  }
}
