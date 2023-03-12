import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_example/core/error/failures.dart';
import 'package:flutter_clean_architecture_example/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_clean_architecture_example/features/number_trivia/domain/repositories/get_concrete_number_trivia_repository.dart';

import '../../../../core/platform/network_info.dart';
import '../datasources/get_concrete_number_trivia_datasource.dart';

class GetConcreteNumberTriviaRepositoryImp
    implements GetConcreteNumberTriviaRepository {
  final GetConcreteNumberTriviaDataSource dataSource;
  final NetworkInfo networkInfo;
  GetConcreteNumberTriviaRepositoryImp(
      {required this.dataSource, required this.networkInfo});

  @override
  Future<Either<Failure, NumberTriviaEntity>> call(int number) {
    // TODO: implement call
    throw UnimplementedError();
  }
}
