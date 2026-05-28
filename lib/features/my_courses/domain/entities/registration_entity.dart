import 'package:equatable/equatable.dart';

class RegistrationEntity extends Equatable {
  final String regId;
  final String userId;
  final String courseId;
  final String courseTitle;
  final String courseCode;
  final int courseCredits;
  final String instructor;
  final DateTime registeredAt;

  const RegistrationEntity({
    required this.regId,
    required this.userId,
    required this.courseId,
    required this.courseTitle,
    required this.courseCode,
    required this.courseCredits,
    required this.instructor,
    required this.registeredAt,
  });

  @override
  List<Object?> get props => [
    regId,
    userId,
    courseId,
    courseTitle,
    courseCode,
    courseCredits,
    instructor,
    registeredAt,
  ];
}
