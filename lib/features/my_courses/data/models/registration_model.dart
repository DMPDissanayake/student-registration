import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/registration_entity.dart';

class RegistrationModel extends RegistrationEntity {
  const RegistrationModel({
    required super.regId,
    required super.userId,
    required super.courseId,
    required super.courseTitle,
    required super.courseCode,
    required super.courseCredits,
    required super.instructor,
    required super.registeredAt,
  });

  factory RegistrationModel.fromFirestore({
    required DocumentSnapshot registrationDoc,
    required DocumentSnapshot courseDoc,
  }) {
    final regData = registrationDoc.data() as Map<String, dynamic>?;
    final courseData = courseDoc.data() as Map<String, dynamic>?;

    return RegistrationModel(
      regId: registrationDoc.id,
      userId: regData?['userId'] ?? '',
      courseId: regData?['courseId'] ?? '',
      courseTitle: courseData?['title'] ?? 'Unknown Course',
      courseCode: courseData?['code'] ?? '',
      courseCredits: courseData?['credits'] is int
          ? courseData!['credits']
          : int.parse((courseData?['credits'] ?? 0).toString()),
      instructor: courseData?['instructor'] ?? '',
      registeredAt: regData?['registeredAt'] != null
          ? (regData!['registeredAt'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'courseId': courseId,
      'registeredAt': Timestamp.fromDate(registeredAt),
    };
  }
}
