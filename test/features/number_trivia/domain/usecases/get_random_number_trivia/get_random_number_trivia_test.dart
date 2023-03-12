// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_example/core/usecase/usecase.dart';
import 'package:flutter_clean_architecture_example/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_clean_architecture_example/features/number_trivia/domain/repositories/get_random_number_trivia_repository.dart';
import 'package:flutter_clean_architecture_example/features/number_trivia/domain/usecases/get_random_number_trivia_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import './get_random_number_trivia_test.mocks.dart';

@GenerateMocks([GetRandomNumberTriviaRepository])
void main() {
  late MockGetRandomNumberTriviaRepository mockGetRandomNumberTriviaRepository;
  late GetRandomNumberTriviaUsecase usecase;
  late NumberTriviaEntity tNumberTrivia;

  setUp(() {
    mockGetRandomNumberTriviaRepository = MockGetRandomNumberTriviaRepository();
    usecase = GetRandomNumberTriviaUsecase(mockGetRandomNumberTriviaRepository);
    tNumberTrivia = const NumberTriviaEntity(number: 1, text: 'test');
  });

  test(
    'should get trivia from the repository',
    () async {
      //arange

      when(mockGetRandomNumberTriviaRepository())
          .thenAnswer((_) async => Right(tNumberTrivia));
      //act
      final result = await usecase(NoParams());
      //assert
      expect(result, equals(Right(tNumberTrivia)));
      verify(mockGetRandomNumberTriviaRepository());
      verifyNoMoreInteractions(mockGetRandomNumberTriviaRepository);
    },
  );
}
