import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/course_entity.dart';
import '../repositories/courses_repository.dart';

@lazySingleton
class GetCoursesUseCase implements UseCase<List<CourseEntity>, NoParams> {
  final CoursesRepository repository;

  GetCoursesUseCase(this.repository);

  @override
  Future<Either<Failure, List<CourseEntity>>> call(NoParams params) async {
    return await repository.getCourses();
  }
}
