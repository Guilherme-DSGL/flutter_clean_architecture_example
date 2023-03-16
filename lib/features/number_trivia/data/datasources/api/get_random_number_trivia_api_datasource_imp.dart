import 'package:flutter_clean_architecture_example/core/error/exceptions.dart';

import '../../../../../core/network/http_client/http_client.dart';
import '../../dto/number_trivia_dto.dart';
import '../get_random_number_trivia_datasource.dart';

class GetRandomNumberTriviaApiDataSourceImp
    implements GetRandomNumberTriviaDataSource {
  final HttpClientAdapter httpClientAdapter;
  GetRandomNumberTriviaApiDataSourceImp(this.httpClientAdapter);

  @override
  Future<NumberTriviaDTO> call() async {
    const url = "$kApiUrl/random";
    final response = await httpClientAdapter
        .get(url, headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      return NumberTriviaDTO.fromJson(response.body);
    } else {
      throw ServerException();
    }
  }
}
