import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info/network_info.dart';
import '../../domain/entities/number_trivia.dart';
import '../../domain/repositories/get_concrete_number_trivia_repository.dart';
import '../datasources/cache_number_trivia_datasource.dart';
import '../datasources/get_concrete_number_trivia_datasource.dart';
import '../datasources/get_last_number_trivia_datasource.dart';

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
