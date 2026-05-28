import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/registration_entity.dart';

abstract class MyCoursesRepository {
  Future<Either<Failure, List<RegistrationEntity>>> getMyCourses(String userId);
}
