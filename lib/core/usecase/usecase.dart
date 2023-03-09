import 'package:dartz/dartz.dart';

import '../error/failures.dart';

abstract class UseCase<Output, Input> {
  Future<Either<Failure, Output>?> call(Input param);
}
