import 'package:equatable/equatable.dart';
import '../../domain/entities/course_entity.dart';

abstract class CoursesState extends Equatable {
  const CoursesState();

  @override
  List<Object?> get props => [];
}

class CoursesInitial extends CoursesState {}

class CoursesLoading extends CoursesState {}

class CoursesLoaded extends CoursesState {
  final List<CourseEntity> courses;

  const CoursesLoaded({required this.courses});

  @override
  List<Object?> get props => [courses];
}

class CourseRegistrationSuccess extends CoursesState {
  final String message;

  const CourseRegistrationSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class CoursesError extends CoursesState {
  final String message;

  const CoursesError({required this.message});

  @override
  List<Object?> get props => [message];
}
