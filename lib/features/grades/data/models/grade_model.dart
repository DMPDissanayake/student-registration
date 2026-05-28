import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/grade_entity.dart';

class GradeModel extends GradeEntity {
  const GradeModel({
    required super.gradeId,
    required super.userId,
    required super.courseId,
    required super.courseTitle,
    required super.courseCode,
    required super.assignmentName,
    required super.marks,
    required super.totalMarks,
    required super.grade,
  });

  factory GradeModel.fromFirestore({
    required DocumentSnapshot gradeDoc,
    required DocumentSnapshot courseDoc,
  }) {
    final gradeData = gradeDoc.data() as Map<String, dynamic>?;
    final courseData = courseDoc.data() as Map<String, dynamic>?;

    return GradeModel(
      gradeId: gradeDoc.id,
      userId: gradeData?['userId'] ?? '',
      courseId: gradeData?['courseId'] ?? '',
      courseTitle: courseData?['title'] ?? 'Unknown Course',
      courseCode: courseData?['code'] ?? '',
      assignmentName: gradeData?['assignmentName'] ?? '',
      marks: (gradeData?['marks'] ?? 0.0).toDouble(),
      totalMarks: (gradeData?['totalMarks'] ?? 100.0).toDouble(),
      grade: gradeData?['grade'] ?? 'N/A',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'courseId': courseId,
      'assignmentName': assignmentName,
      'marks': marks,
      'totalMarks': totalMarks,
      'grade': grade,
    };
  }
}
