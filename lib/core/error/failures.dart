import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {}

class CacheFailure extends Failure {}

const CACHE_FAILURE_MESSAGE = "ocorreu um erro com o cache do app";

const SERVER_FAILURE_MESSAGE = "ocorreu um erro com o server do app";

const DEFAULT_MESSAGE = "ocorreu um erro";
String getFailureMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return SERVER_FAILURE_MESSAGE;
    case CacheFailure:
      return CACHE_FAILURE_MESSAGE;
    default:
      return DEFAULT_MESSAGE;
  }
}
