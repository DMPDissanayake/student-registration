import 'package:equatable/equatable.dart';

abstract class CoursesEvent extends Equatable {
  const CoursesEvent();

  @override
  List<Object?> get props => [];
}

class FetchCourses extends CoursesEvent {}

class RegisterInCourse extends CoursesEvent {
  final String userId;
  final String courseId;

  const RegisterInCourse({required this.userId, required this.courseId});

  @override
  List<Object?> get props => [userId, courseId];
}
