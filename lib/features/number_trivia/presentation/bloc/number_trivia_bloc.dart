import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_example/core/usecase/usecase.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/number_trivia.dart';
import '../../domain/usecases/get_concrete_number_trivia_usecase.dart';
import '../../domain/usecases/get_random_number_trivia_usecase.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTriviaUsecase getconcreteNumberTriviaUsecase;
  final GetRandomNumberTriviaUsecase getRandomNumberTriviaUsecase;

  NumberTriviaBloc(
      {required this.getconcreteNumberTriviaUsecase,
      required this.getRandomNumberTriviaUsecase})
      : super(Empty()) {
    on<GetTriviaForConcreteNumber>(_onGetTriviaForConcreteNumber);
    on<GetTriviaForRandomNumber>(_onGetTriviaForRandomNumber);
  }

  _onGetTriviaForConcreteNumber(
      GetTriviaForConcreteNumber event, Emitter<NumberTriviaState> emit) async {
    emit(Loading());
    final result = await getconcreteNumberTriviaUsecase(event.number);
    result.fold(
      (failure) => emit(Error(message: getFailureMessage(failure))),
      (numberTrivia) => emit(Loaded(trivia: numberTrivia)),
    );
  }

  _onGetTriviaForRandomNumber(
      GetTriviaForRandomNumber event, Emitter<NumberTriviaState> emit) async {
    emit(Loading());
    final result = await getRandomNumberTriviaUsecase(NoParams());
    result.fold((failure) => emit(Error(message: getFailureMessage(failure))),
        (numberTrivia) => emit(Loaded(trivia: numberTrivia)));
  }
}
