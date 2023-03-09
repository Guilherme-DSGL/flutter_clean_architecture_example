// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_example/core/error/failures.dart';
import 'package:flutter_clean_architecture_example/core/usecase/usecase.dart';
import 'package:flutter_clean_architecture_example/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_clean_architecture_example/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class GetConcreteNumberTriviaUsecase
    implements UseCase<NumberTriviaEntity, int> {
  final NumberTriviaRepository repository;
  GetConcreteNumberTriviaUsecase(this.repository);

  @override
  Future<Either<Failure, NumberTriviaEntity>?> call(int param) async {
    return await repository.getConcreteNumberTrivia(param);
  }
}
