import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/number_trivia.dart';

abstract class GetRandomNumberTriviaRepository {
  Future<Either<Failure, NumberTriviaEntity>> call();
}
