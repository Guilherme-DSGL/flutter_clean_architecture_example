import 'package:flutter_clean_architecture_example/core/error/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/entities/number_trivia.dart';
import '../../dto/number_trivia_dto.dart';
import '../get_last_number_trivia_datasource.dart';

const kcacheNumberTrivia = "CACHED_NUMBER_TRIVIA";

class GetLastNumberTriviaLocalDataSourceImp
    implements GetLastNumberTriviaLocalDataSource {
  final SharedPreferences sharedPreferences;

  GetLastNumberTriviaLocalDataSourceImp({required this.sharedPreferences});

  @override
  Future<NumberTriviaEntity> call() async {
    final jsonString = sharedPreferences.getString(kcacheNumberTrivia);
    if (jsonString != null) {
      return Future.value(NumberTriviaDTO.fromJson(jsonString));
    } else {
      throw CacheException();
    }
  }
}
