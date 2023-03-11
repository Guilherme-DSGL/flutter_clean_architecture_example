// ignore_for_file: public_member_api_docs, sort_constructors_first, annotate_overrides
import 'dart:convert';

import '../../domain/entities/number_trivia.dart';

class NumberTriviaDTO extends NumberTriviaEntity {
  // ignore: overridden_fields
  final String text;
  // ignore: overridden_fields
  final double number;
  const NumberTriviaDTO({
    required this.text,
    required this.number,
  }) : super(text: text, number: number);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'number': number,
    };
  }

  factory NumberTriviaDTO.fromMap(Map<String, dynamic> map) {
    return NumberTriviaDTO(
      text: map['text'] as String,
      number: (map['number'] as num).toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory NumberTriviaDTO.fromJson(String source) =>
      NumberTriviaDTO.fromMap(json.decode(source) as Map<String, dynamic>);
}
