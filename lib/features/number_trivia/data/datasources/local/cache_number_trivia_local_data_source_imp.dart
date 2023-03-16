import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../dto/number_trivia_dto.dart';
import '../cache_number_trivia_datasource.dart';
import 'get_last_number_trivia_local_data_source_imp.dart';

class CacheNumberTriviaLocalDataSourceImp
    implements CacheNumberTriviaDataSource {
  final SharedPreferences sharedPreferences;

  CacheNumberTriviaLocalDataSourceImp({required this.sharedPreferences});
  @override
  void call({required NumberTriviaDTO numberTriviaToCache}) {
    sharedPreferences.setString(
        kcacheNumberTrivia, json.encode(numberTriviaToCache.toJson()));
  }
}
