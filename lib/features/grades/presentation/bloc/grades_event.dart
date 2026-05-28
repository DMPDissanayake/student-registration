import 'package:equatable/equatable.dart';

abstract class GradesEvent extends Equatable {
  const GradesEvent();

  @override
  List<Object?> get props => [];
}

class FetchGrades extends GradesEvent {
  final String userId;

  const FetchGrades({required this.userId});

  @override
  List<Object?> get props => [userId];
}
