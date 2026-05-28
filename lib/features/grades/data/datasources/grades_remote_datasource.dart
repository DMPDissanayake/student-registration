import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/constants/firebase_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/grade_model.dart';

abstract class GradesRemoteDataSource {
  Future<List<GradeModel>> getGrades(String userId);
}

@LazySingleton(as: GradesRemoteDataSource)
class GradesRemoteDataSourceImpl implements GradesRemoteDataSource {
  final FirebaseFirestore firestore;

  GradesRemoteDataSourceImpl(this.firestore);

  @override
  Future<List<GradeModel>> getGrades(String userId) async {
    try {
      final gradeSnapshot = await firestore
          .collection(FirebaseConstants.gradesCollection)
          .where('userId', isEqualTo: userId)
          .get();

      List<GradeModel> gradesList = [];

      for (var gradeDoc in gradeSnapshot.docs) {
        final courseId = gradeDoc.data()['courseId'];
        final courseDoc = await firestore
            .collection(FirebaseConstants.coursesCollection)
            .doc(courseId)
            .get();

        gradesList.add(
          GradeModel.fromFirestore(gradeDoc: gradeDoc, courseDoc: courseDoc),
        );
      }

      return gradesList;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
