import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/number_trivia.dart';

abstract class GetConcreteNumberTriviaRepository {
  Future<Either<Failure, NumberTriviaEntity>> call(int number);
}
