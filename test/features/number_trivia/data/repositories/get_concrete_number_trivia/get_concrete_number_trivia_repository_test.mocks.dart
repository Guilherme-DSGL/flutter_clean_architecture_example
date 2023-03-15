// Mocks generated by Mockito 5.3.2 from annotations
// in flutter_clean_architecture_example/test/features/number_trivia/data/repositories/get_concrete_number_trivia/get_concrete_number_trivia_repository_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:flutter_clean_architecture_example/core/network/network_info.dart'
    as _i4;
import 'package:flutter_clean_architecture_example/features/number_trivia/data/datasources/cache_number_trivia_datasource.dart'
    as _i7;
import 'package:flutter_clean_architecture_example/features/number_trivia/data/datasources/get_concrete_number_trivia_datasource.dart'
    as _i6;
import 'package:flutter_clean_architecture_example/features/number_trivia/data/datasources/get_last_number_trivia_datasource.dart'
    as _i8;
import 'package:flutter_clean_architecture_example/features/number_trivia/data/dto/number_trivia_dto.dart'
    as _i2;
import 'package:flutter_clean_architecture_example/features/number_trivia/domain/entities/number_trivia.dart'
    as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeNumberTriviaDTO_0 extends _i1.SmartFake
    implements _i2.NumberTriviaDTO {
  _FakeNumberTriviaDTO_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeNumberTriviaEntity_1 extends _i1.SmartFake
    implements _i3.NumberTriviaEntity {
  _FakeNumberTriviaEntity_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i4.NetworkInfo {
  MockNetworkInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<bool> get isConected => (super.noSuchMethod(
        Invocation.getter(#isConected),
        returnValue: _i5.Future<bool>.value(false),
      ) as _i5.Future<bool>);
}

/// A class which mocks [GetConcreteNumberTriviaDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetConcreteNumberTriviaDataSource extends _i1.Mock
    implements _i6.GetConcreteNumberTriviaDataSource {
  MockGetConcreteNumberTriviaDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i2.NumberTriviaDTO> call({required int? number}) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [],
          {#number: number},
        ),
        returnValue:
            _i5.Future<_i2.NumberTriviaDTO>.value(_FakeNumberTriviaDTO_0(
          this,
          Invocation.method(
            #call,
            [],
            {#number: number},
          ),
        )),
      ) as _i5.Future<_i2.NumberTriviaDTO>);
}

/// A class which mocks [CacheNumberTriviaDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockCacheNumberTriviaDataSource extends _i1.Mock
    implements _i7.CacheNumberTriviaDataSource {
  MockCacheNumberTriviaDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  void call({required _i3.NumberTriviaEntity? numberTriviaToCache}) =>
      super.noSuchMethod(
        Invocation.method(
          #call,
          [],
          {#numberTriviaToCache: numberTriviaToCache},
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [GetLastNumberTriviaLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetLastNumberTriviaLocalDataSource extends _i1.Mock
    implements _i8.GetLastNumberTriviaLocalDataSource {
  MockGetLastNumberTriviaLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i3.NumberTriviaEntity> call() => (super.noSuchMethod(
        Invocation.method(
          #call,
          [],
        ),
        returnValue:
            _i5.Future<_i3.NumberTriviaEntity>.value(_FakeNumberTriviaEntity_1(
          this,
          Invocation.method(
            #call,
            [],
          ),
        )),
      ) as _i5.Future<_i3.NumberTriviaEntity>);
}
