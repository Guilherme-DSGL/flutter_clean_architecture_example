import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_example/core/error/failures.dart';
import 'package:flutter_clean_architecture_example/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_clean_architecture_example/features/number_trivia/domain/usecases/get_concrete_number_trivia_usecase.dart';
import 'package:flutter_clean_architecture_example/features/number_trivia/domain/usecases/get_random_number_trivia_usecase.dart';
import 'package:flutter_clean_architecture_example/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'number_trivia_bloc_test.mocks.dart';

@GenerateMocks([GetConcreteNumberTriviaUsecase, GetRandomNumberTriviaUsecase])
void main() {
  late NumberTriviaBloc bloc;
  late MockGetConcreteNumberTriviaUsecase mockGetConcreteNumberTriviaUseCase;
  late MockGetRandomNumberTriviaUsecase mockGetRandomNumberTriviaUseCase;

  setUp(() {
    mockGetConcreteNumberTriviaUseCase = MockGetConcreteNumberTriviaUsecase();
    mockGetRandomNumberTriviaUseCase = MockGetRandomNumberTriviaUsecase();
    bloc = NumberTriviaBloc(
        getconcreteNumberTriviaUsecase: mockGetConcreteNumberTriviaUseCase,
        getRandomNumberTriviaUsecase: mockGetRandomNumberTriviaUseCase);
  });

  test("initial should be Empty", () {
    expect(bloc.state, equals(NumberTriviaStateEmpty()));
  });

  group("GetTriviaForConcreteNumber", () {
    const tnumber = 1;
    const tNumberTrivia =
        NumberTriviaEntity(number: tnumber, text: "Test trivia");
    setUp(() {
      when(mockGetConcreteNumberTriviaUseCase(tnumber))
          .thenAnswer((_) async => const Right(tNumberTrivia));
    });
    test("Should call a getConcreteNumberTriviaUseCase", () async {
      when(mockGetConcreteNumberTriviaUseCase(tnumber)).thenAnswer((_) async {
        return const Right(tNumberTrivia);
      });

      bloc.add(const GetTriviaForConcreteNumber(number: tnumber));
      await untilCalled(mockGetConcreteNumberTriviaUseCase(tnumber));

      verify(mockGetConcreteNumberTriviaUseCase(tnumber));
    });

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'emits [NumberTriviaStateLoading and Loaded] when GetTriviaForConcreteNumber is added.',
      build: () => bloc,
      act: (bloc) =>
          bloc.add(const GetTriviaForConcreteNumber(number: tnumber)),
      expect: () => <NumberTriviaState>[
        NumberTriviaStateLoading(),
        const NumberTriviaStateLoaded(trivia: tNumberTrivia)
      ],
    );
  });

  group("test bloc errors", () {
    const tnumber = 1;
    setUp(() {
      when(mockGetConcreteNumberTriviaUseCase(tnumber))
          .thenAnswer((_) async => Left(ServerFailure()));
    });
    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'emits [NumberTriviaStateEror] when GetTriviaForConcreteNumber is added.',
      build: () => bloc,
      act: (bloc) =>
          bloc.add(const GetTriviaForConcreteNumber(number: tnumber)),
      expect: () => <NumberTriviaState>[
        NumberTriviaStateLoading(),
        const NumberTriviaStateError(message: "error")
      ],
    );
  });
}
