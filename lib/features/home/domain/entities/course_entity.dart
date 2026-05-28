import 'package:equatable/equatable.dart';

class CourseEntity extends Equatable {
  final String courseId;
  final String title;
  final String code;
  final String description;
  final int credits;
  final String instructor;
  final String schedule;

  const CourseEntity({
    required this.courseId,
    required this.title,
    required this.code,
    required this.description,
    required this.credits,
    required this.instructor,
    required this.schedule,
  });

  @override
  List<Object?> get props => [
    courseId,
    title,
    code,
    description,
    credits,
    instructor,
    schedule,
  ];
}
