import 'package:equatable/equatable.dart';

class GradeEntity extends Equatable {
  final String gradeId;
  final String userId;
  final String courseId;
  final String courseTitle;
  final String courseCode;
  final String assignmentName;
  final double marks;
  final double totalMarks;
  final String grade;

  const GradeEntity({
    required this.gradeId,
    required this.userId,
    required this.courseId,
    required this.courseTitle,
    required this.courseCode,
    required this.assignmentName,
    required this.marks,
    required this.totalMarks,
    required this.grade,
  });

  @override
  List<Object?> get props => [
    gradeId,
    userId,
    courseId,
    courseTitle,
    courseCode,
    assignmentName,
    marks,
    totalMarks,
    grade,
  ];
}
