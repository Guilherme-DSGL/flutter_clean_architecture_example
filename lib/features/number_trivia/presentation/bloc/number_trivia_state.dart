part of 'number_trivia_bloc.dart';

abstract class NumberTriviaState extends Equatable {
  const NumberTriviaState();

  @override
  List<Object> get props => [];
}

class NumberTriviaStateEmpty extends NumberTriviaState {}

class NumberTriviaStateLoading extends NumberTriviaState {}

class NumberTriviaStateLoaded extends NumberTriviaState {
  final NumberTriviaEntity trivia;

  const NumberTriviaStateLoaded({required this.trivia});
}

class NumberTriviaStateError extends NumberTriviaState {
  final String message;

  const NumberTriviaStateError({required this.message});
}
