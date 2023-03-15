import 'dart:convert';

import 'package:flutter_clean_architecture_example/features/number_trivia/data/datasources/local/get_last_number_trivia_local_data_source_imp.dart';
import 'package:flutter_clean_architecture_example/features/number_trivia/data/dto/number_trivia_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../cache_number_trivia_datasource.dart';

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
