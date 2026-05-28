import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/registration_entity.dart';
import '../repositories/my_courses_repository.dart';

@lazySingleton
class GetMyCoursesUseCase implements UseCase<List<RegistrationEntity>, String> {
  final MyCoursesRepository repository;

  GetMyCoursesUseCase(this.repository);

  @override
  Future<Either<Failure, List<RegistrationEntity>>> call(String userId) async {
    return await repository.getMyCourses(userId);
  }
}
