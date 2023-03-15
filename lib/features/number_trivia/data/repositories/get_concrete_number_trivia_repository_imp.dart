import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_example/core/error/exceptions.dart';
import 'package:flutter_clean_architecture_example/core/error/failures.dart';
import 'package:flutter_clean_architecture_example/features/number_trivia/data/datasources/cache_number_trivia_datasource.dart';
import 'package:flutter_clean_architecture_example/features/number_trivia/data/datasources/get_last_number_trivia_datasource.dart';
import 'package:flutter_clean_architecture_example/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_clean_architecture_example/features/number_trivia/domain/repositories/get_concrete_number_trivia_repository.dart';

import '../../../../core/network/network_info.dart';
import '../datasources/get_concrete_number_trivia_datasource.dart';

class GetConcreteNumberTriviaRepositoryImp
    implements GetConcreteNumberTriviaRepository {
  final GetConcreteNumberTriviaDataSource getConcreteNumberTriviaDataSource;
  final CacheNumberTriviaDataSource cacheNumberTriviaDataSource;
  final GetLastNumberTriviaLocalDataSource getLastNumberTriviaLocalDataSource;
  final NetworkInfo networkInfo;
  GetConcreteNumberTriviaRepositoryImp({
    required this.getLastNumberTriviaLocalDataSource,
    required this.getConcreteNumberTriviaDataSource,
    required this.cacheNumberTriviaDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, NumberTriviaEntity>> call(int number) async {
    if (await networkInfo.isConected) {
      try {
        final result = await getConcreteNumberTriviaDataSource(number: number);
        cacheNumberTriviaDataSource(numberTriviaToCache: result);
        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final result = await getLastNumberTriviaLocalDataSource();
        return Right(result);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
