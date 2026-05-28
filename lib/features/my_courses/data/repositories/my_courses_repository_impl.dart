import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/registration_entity.dart';
import '../../domain/repositories/my_courses_repository.dart';
import '../datasources/my_courses_remote_datasource.dart';

@LazySingleton(as: MyCoursesRepository)
class MyCoursesRepositoryImpl implements MyCoursesRepository {
  final MyCoursesRemoteDataSource remoteDataSource;

  MyCoursesRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<RegistrationEntity>>> getMyCourses(
    String userId,
  ) async {
    try {
      final registrations = await remoteDataSource.getMyCourses(userId);
      return Right(registrations);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
