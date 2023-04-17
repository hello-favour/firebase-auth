// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Errorhandler extends Equatable implements Exception {
  final String message;
  const Errorhandler({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
