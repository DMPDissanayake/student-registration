import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/courses_repository.dart';

@lazySingleton
class RegisterCourseUseCase implements UseCase<void, CourseRegistrationParams> {
  final CoursesRepository repository;

  RegisterCourseUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(CourseRegistrationParams params) async {
    return await repository.registerCourse(params.userId, params.courseId);
  }
}

class CourseRegistrationParams extends Equatable {
  final String userId;
  final String courseId;

  const CourseRegistrationParams({
    required this.userId,
    required this.courseId,
  });

  @override
  List<Object?> get props => [userId, courseId];
}
