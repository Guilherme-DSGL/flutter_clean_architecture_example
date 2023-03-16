import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info/network_info.dart';
import '../../domain/entities/number_trivia.dart';
import '../../domain/repositories/get_random_number_trivia_repository.dart';
import '../datasources/cache_number_trivia_datasource.dart';
import '../datasources/get_last_number_trivia_datasource.dart';
import '../datasources/get_random_number_trivia_datasource.dart';

class GetRandomNumberTriviaRepositoryImp
    implements GetRandomNumberTriviaRepository {
  final GetRandomNumberTriviaDataSource getRandomNumberTriviaDataSource;
  final CacheNumberTriviaDataSource cacheNumberTriviaDataSource;
  final GetLastNumberTriviaLocalDataSource getLastNumberTriviaLocalDataSource;
  final NetworkInfo networkInfo;
  GetRandomNumberTriviaRepositoryImp(
      {required this.getRandomNumberTriviaDataSource,
      required this.cacheNumberTriviaDataSource,
      required this.getLastNumberTriviaLocalDataSource,
      required this.networkInfo});
  @override
  Future<Either<Failure, NumberTriviaEntity>> call() async {
    if (await networkInfo.isConected) {
      try {
        final result = await getRandomNumberTriviaDataSource();
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
