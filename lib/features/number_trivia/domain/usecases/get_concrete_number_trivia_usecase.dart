import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_example/features/number_trivia/domain/repositories/get_concrete_number_trivia_repository.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/number_trivia.dart';

class GetConcreteNumberTriviaUsecase
    implements UseCase<NumberTriviaEntity, int> {
  final GetConcreteNumberTriviaRepository repository;
  GetConcreteNumberTriviaUsecase(this.repository);

  @override
  Future<Either<Failure, NumberTriviaEntity>> call(int param) async {
    return await repository(param);
  }
}
