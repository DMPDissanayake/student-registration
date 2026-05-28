import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/grade_entity.dart';
import '../repositories/grades_repository.dart';

@lazySingleton
class GetGradesUseCase implements UseCase<List<GradeEntity>, String> {
  final GradesRepository repository;

  GetGradesUseCase(this.repository);

  @override
  Future<Either<Failure, List<GradeEntity>>> call(String userId) async {
    return await repository.getGrades(userId);
  }
}
