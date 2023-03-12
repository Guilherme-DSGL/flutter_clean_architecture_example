import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/number_trivia.dart';
import '../repositories/get_random_number_trivia_repository.dart';

class GetRandomNumberTriviaUsecase
    implements UseCase<NumberTriviaEntity, NoParams> {
  final GetRandomNumberTriviaRepository repository;
  GetRandomNumberTriviaUsecase(this.repository);
  @override
  Future<Either<Failure, NumberTriviaEntity>> call(NoParams param) async {
    return repository();
  }
}
