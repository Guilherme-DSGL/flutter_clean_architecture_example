import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

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
      : super(NumberTriviaStateEmpty()) {
    on<GetTriviaForConcreteNumber>((event, emit) async {
      emit(NumberTriviaStateLoading());
      final result = await getconcreteNumberTriviaUsecase(event.number);
      result.fold(
        (failure) =>
            emit(const NumberTriviaStateError(message: "message error")),
        (numberTrivia) => emit(NumberTriviaStateLoaded(trivia: numberTrivia)),
      );
    });

    on<GetTriviaForRandomNumber>((event, emit) {});
  }
}
