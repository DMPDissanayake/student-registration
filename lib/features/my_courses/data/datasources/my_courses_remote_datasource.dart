import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/constants/firebase_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/registration_model.dart';

abstract class MyCoursesRemoteDataSource {
  Future<List<RegistrationModel>> getMyCourses(String userId);
}

@LazySingleton(as: MyCoursesRemoteDataSource)
class MyCoursesRemoteDataSourceImpl implements MyCoursesRemoteDataSource {
  final FirebaseFirestore firestore;

  MyCoursesRemoteDataSourceImpl(this.firestore);

  @override
  Future<List<RegistrationModel>> getMyCourses(String userId) async {
    try {
      final registrationSnapshot = await firestore
          .collection(FirebaseConstants.registrationsCollection)
          .where('userId', isEqualTo: userId)
          .get();

      List<RegistrationModel> myCoursesList = [];

      for (var regDoc in registrationSnapshot.docs) {
        final courseId = regDoc.data()['courseId'];
        final courseDoc = await firestore
            .collection(FirebaseConstants.coursesCollection)
            .doc(courseId)
            .get();

        if (courseDoc.exists) {
          myCoursesList.add(
            RegistrationModel.fromFirestore(
              registrationDoc: regDoc,
              courseDoc: courseDoc,
            ),
          );
        }
      }

      return myCoursesList;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
