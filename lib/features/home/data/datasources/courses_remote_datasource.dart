import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/constants/firebase_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/course_model.dart';

abstract class CoursesRemoteDataSource {
  Future<List<CourseModel>> getCourses();
  Future<void> registerCourse(String userId, String courseId);
}

@LazySingleton(as: CoursesRemoteDataSource)
class CoursesRemoteDataSourceImpl implements CoursesRemoteDataSource {
  final FirebaseFirestore firestore;

  CoursesRemoteDataSourceImpl(this.firestore);

  @override
  Future<List<CourseModel>> getCourses() async {
    try {
      final querySnapshot = await firestore
          .collection(FirebaseConstants.coursesCollection)
          .get();
      return querySnapshot.docs
          .map((doc) => CourseModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> registerCourse(String userId, String courseId) async {
    try {
      final regId = '${userId}_$courseId';

      // Check if registration already exists
      final doc = await firestore
          .collection(FirebaseConstants.registrationsCollection)
          .doc(regId)
          .get();
      if (doc.exists) {
        throw const ServerException(
          'You are already registered for this course.',
        );
      }

      await firestore
          .collection(FirebaseConstants.registrationsCollection)
          .doc(regId)
          .set({
            'userId': userId,
            'courseId': courseId,
            'registeredAt': FieldValue.serverTimestamp(),
          });
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
