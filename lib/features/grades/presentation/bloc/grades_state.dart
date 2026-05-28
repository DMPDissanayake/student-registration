import 'package:equatable/equatable.dart';
import '../../domain/entities/grade_entity.dart';

abstract class GradesState extends Equatable {
  const GradesState();

  @override
  List<Object?> get props => [];
}

class GradesInitial extends GradesState {}

class GradesLoading extends GradesState {}

class GradesLoaded extends GradesState {
  final List<GradeEntity> grades;

  const GradesLoaded({required this.grades});

  @override
  List<Object?> get props => [grades];
}

class GradesError extends GradesState {
  final String message;

  const GradesError({required this.message});

  @override
  List<Object?> get props => [message];
}
