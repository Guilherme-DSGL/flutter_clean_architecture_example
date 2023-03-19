// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'number_trivia_bloc.dart';

abstract class NumberTriviaEvent extends Equatable {
  const NumberTriviaEvent();

  @override
  List<Object> get props => [];
}

class GetTriviaForConcreteNumber extends NumberTriviaEvent {
  final int number;
  const GetTriviaForConcreteNumber({
    required this.number,
  });
}

class GetTriviaForRandomNumber extends NumberTriviaEvent {}
