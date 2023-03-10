import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_example/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_clean_architecture_example/features/number_trivia/domain/repositories/get_concrete_number_trivia_repository.dart';
import 'package:flutter_clean_architecture_example/features/number_trivia/domain/usecases/get_concrete_number_trivia_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import './get_concrete_number_trivia_test.mocks.dart';

@GenerateMocks([GetConcreteNumberTriviaRepository])
void main() {
  late MockGetConcreteNumberTriviaRepository mockNumberTriviaRepository;
  late GetConcreteNumberTriviaUsecase usecase;
  late int tNumber;
  late NumberTriviaEntity tNumberTrivia;

  setUp(() {
    mockNumberTriviaRepository = MockGetConcreteNumberTriviaRepository();
    usecase = GetConcreteNumberTriviaUsecase(mockNumberTriviaRepository);
    tNumberTrivia = const NumberTriviaEntity(number: 1, text: 'test');
    tNumber = 1;
  });

  test(
    'should get trivia for the number from the repository',
    () async {
      //arange

      when(mockNumberTriviaRepository(any))
          .thenAnswer((_) async => Right(tNumberTrivia));
      //act
      final result = await usecase(1);
      //assert
      expect(result, equals(Right(tNumberTrivia)));
      verify(mockNumberTriviaRepository(tNumber));
      verifyNoMoreInteractions(mockNumberTriviaRepository);
    },
  );
}
