import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_example/core/error/failures.dart';
import 'package:flutter_clean_architecture_example/core/usecase/usecase.dart';
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
    expect(bloc.state, equals(Empty()));
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
      'should call the getConcreteNumberTrivia usecase',
      build: () => bloc,
      setUp: () => when(mockGetConcreteNumberTriviaUseCase(any))
          .thenAnswer((_) async => const Right(tNumberTrivia)),
      act: (bloc) =>
          bloc.add(const GetTriviaForConcreteNumber(number: tnumber)),
      verify: (_) => mockGetConcreteNumberTriviaUseCase(tnumber),
    );

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'should emits a [NumberTriviaLoaded] when the getConcreteNumberTrivia usecase is successful',
      build: () => bloc,
      setUp: () => when(mockGetConcreteNumberTriviaUseCase(tnumber))
          .thenAnswer((_) async => const Right(tNumberTrivia)),
      act: (bloc) =>
          bloc.add(const GetTriviaForConcreteNumber(number: tnumber)),
      expect: () => [Loading(), const Loaded(trivia: tNumberTrivia)],
    );

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'emits [NumberTriviaStateError] when GetTriviaForConcreteNumber is added.',
      setUp: () => when(mockGetConcreteNumberTriviaUseCase(tnumber))
          .thenAnswer((_) async => Left(ServerFailure())),
      build: () => bloc,
      act: (bloc) =>
          bloc.add(const GetTriviaForConcreteNumber(number: tnumber)),
      expect: () => <NumberTriviaState>[
        Loading(),
        const Error(message: SERVER_FAILURE_MESSAGE)
      ],
    );
  });

  group("GetTriviaForRandomNumber", () {
    const tnumber = 1;
    const tNumberTrivia =
        NumberTriviaEntity(number: tnumber, text: "Test trivia");
    setUp(() {
      when(mockGetRandomNumberTriviaUseCase(any))
          .thenAnswer((_) async => const Right(tNumberTrivia));
    });
    test("Should call a getRandomNumberTriviaUseCase", () async {
      when(mockGetConcreteNumberTriviaUseCase(tnumber)).thenAnswer((_) async {
        return const Right(tNumberTrivia);
      });

      bloc.add(GetTriviaForRandomNumber());
      await untilCalled(mockGetRandomNumberTriviaUseCase(NoParams()));

      verify(mockGetRandomNumberTriviaUseCase(NoParams()));
    });

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'should call the getRandomNumberTrivia usecase',
      build: () => bloc,
      setUp: () => when(mockGetRandomNumberTriviaUseCase(any))
          .thenAnswer((_) async => const Right(tNumberTrivia)),
      act: (bloc) => bloc.add(GetTriviaForRandomNumber()),
      verify: (_) => mockGetRandomNumberTriviaUseCase(NoParams()),
    );

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'should emits a [NumberTriviaLoaded] when the getRandomNumberTrivia usecase is successful',
      build: () => bloc,
      setUp: () => when(mockGetRandomNumberTriviaUseCase(NoParams()))
          .thenAnswer((_) async => const Right(tNumberTrivia)),
      act: (bloc) => bloc.add(GetTriviaForRandomNumber()),
      expect: () => [Loading(), const Loaded(trivia: tNumberTrivia)],
    );

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'emits [NumberTriviaStateError] when GetTriviaForRandomNumber is added.',
      setUp: () => when(mockGetRandomNumberTriviaUseCase(NoParams()))
          .thenAnswer((_) async => Left(ServerFailure())),
      build: () => bloc,
      act: (bloc) => bloc.add(GetTriviaForRandomNumber()),
      expect: () => <NumberTriviaState>[
        Loading(),
        const Error(message: SERVER_FAILURE_MESSAGE)
      ],
    );
  });
}
