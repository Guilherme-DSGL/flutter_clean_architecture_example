import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/number_trivia.dart';
import '../../domain/repositories/get_random_number_trivia_repository.dart';
import '../datasources/get_random_number_trivia_datasource.dart';

class GetRandomNumberTriviaRepositoryImp
    implements GetRandomNumberTriviaRepository {
  final GetRandomNumberTriviaDataSource datasource;
  GetRandomNumberTriviaRepositoryImp(this.datasource);
  @override
  Future<Either<Failure, NumberTriviaEntity>> call() {
    // TODO: implement call
    throw UnimplementedError();
  }
}
