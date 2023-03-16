import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/number_trivia.dart';
import '../repositories/get_concrete_number_trivia_repository.dart';

class GetConcreteNumberTriviaUsecase
    implements UseCase<NumberTriviaEntity, int> {
  final GetConcreteNumberTriviaRepository repository;
  GetConcreteNumberTriviaUsecase(this.repository);

  @override
  Future<Either<Failure, NumberTriviaEntity>> call(int param) async {
    return await repository(param);
  }
}
