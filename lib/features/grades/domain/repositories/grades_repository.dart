import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/grade_entity.dart';

abstract class GradesRepository {
  Future<Either<Failure, List<GradeEntity>>> getGrades(String userId);
}
