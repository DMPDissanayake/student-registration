import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/course_entity.dart';

class CourseModel extends CourseEntity {
  const CourseModel({
    required super.courseId,
    required super.title,
    required super.code,
    required super.description,
    required super.credits,
    required super.instructor,
    required super.schedule,
  });

  factory CourseModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data()!;
    return CourseModel(
      courseId: snapshot.id,
      title: data['title'] ?? '',
      code: data['code'] ?? '',
      description: data['description'] ?? '',
      credits: data['credits'] is int
          ? data['credits']
          : int.parse(data['credits'].toString()),
      instructor: data['instructor'] ?? '',
      schedule: data['schedule'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'code': code,
      'description': description,
      'credits': credits,
      'instructor': instructor,
      'schedule': schedule,
    };
  }
}
