import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/grade_entity.dart';
import '../../domain/repositories/grades_repository.dart';
import '../datasources/grades_remote_datasource.dart';

@LazySingleton(as: GradesRepository)
class GradesRepositoryImpl implements GradesRepository {
  final GradesRemoteDataSource remoteDataSource;

  GradesRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<GradeEntity>>> getGrades(String userId) async {
    try {
      final grades = await remoteDataSource.getGrades(userId);
      return Right(grades);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
