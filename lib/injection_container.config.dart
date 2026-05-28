// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:student_registration/features/auth/data/datasources/auth_remote_datasource.dart'
    as _i1027;
import 'package:student_registration/features/auth/data/repositories/auth_repository_impl.dart'
    as _i856;
import 'package:student_registration/features/auth/domain/repositories/auth_repository.dart'
    as _i960;
import 'package:student_registration/features/auth/domain/usecases/login_usecase.dart'
    as _i21;
import 'package:student_registration/features/auth/domain/usecases/register_usecase.dart'
    as _i214;
import 'package:student_registration/features/auth/presentation/bloc/auth_bloc.dart'
    as _i940;
import 'package:student_registration/features/home/data/datasources/courses_remote_datasource.dart'
    as _i580;
import 'package:student_registration/features/home/data/repositories/courses_repository_impl.dart'
    as _i709;
import 'package:student_registration/features/home/domain/repositories/courses_repository.dart'
    as _i828;
import 'package:student_registration/features/home/domain/usecases/get_courses_usecase.dart'
    as _i203;
import 'package:student_registration/features/home/domain/usecases/register_course_usecase.dart'
    as _i154;
import 'package:student_registration/features/home/presentation/bloc/courses_bloc.dart'
    as _i956;
import 'package:student_registration/features/grades/data/datasources/grades_remote_datasource.dart'
    as _i810;
import 'package:student_registration/features/grades/data/repositories/grades_repository_impl.dart'
    as _i215;
import 'package:student_registration/features/grades/domain/repositories/grades_repository.dart'
    as _i883;
import 'package:student_registration/features/grades/domain/usecases/get_grades_usecase.dart'
    as _i230;
import 'package:student_registration/features/grades/presentation/bloc/grades_bloc.dart'
    as _i1000;
import 'package:student_registration/features/my_courses/data/datasources/my_courses_remote_datasource.dart'
    as _i1025;
import 'package:student_registration/features/my_courses/data/repositories/my_courses_repository_impl.dart'
    as _i571;
import 'package:student_registration/features/my_courses/domain/repositories/my_courses_repository.dart'
    as _i677;
import 'package:student_registration/features/my_courses/domain/usecases/get_my_courses_usecase.dart'
    as _i932;
import 'package:student_registration/features/my_courses/presentation/bloc/my_courses_bloc.dart'
    as _i547;
import 'package:student_registration/features/profile/data/datasources/profile_remote_datasource.dart'
    as _i125;
import 'package:student_registration/features/profile/data/repositories/profile_repository_impl.dart'
    as _i675;
import 'package:student_registration/features/profile/domain/repositories/profile_repository.dart'
    as _i304;
import 'package:student_registration/features/profile/domain/usecases/get_profile_usecase.dart'
    as _i473;
import 'package:student_registration/features/profile/domain/usecases/update_profile_usecase.dart'
    as _i568;
import 'package:student_registration/features/profile/presentation/bloc/profile_bloc.dart'
    as _i609;
import 'package:student_registration/injection_container.dart' as _i868;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i59.FirebaseAuth>(() => registerModule.firebaseAuth);
    gh.lazySingleton<_i974.FirebaseFirestore>(() => registerModule.firestore);
    gh.lazySingleton<_i125.ProfileRemoteDataSource>(
      () => _i125.ProfileRemoteDataSourceImpl(gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i1025.MyCoursesRemoteDataSource>(
      () => _i1025.MyCoursesRemoteDataSourceImpl(gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i580.CoursesRemoteDataSource>(
      () => _i580.CoursesRemoteDataSourceImpl(gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i677.MyCoursesRepository>(
      () =>
          _i571.MyCoursesRepositoryImpl(gh<_i1025.MyCoursesRemoteDataSource>()),
    );
    gh.lazySingleton<_i810.GradesRemoteDataSource>(
      () => _i810.GradesRemoteDataSourceImpl(gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i304.ProfileRepository>(
      () => _i675.ProfileRepositoryImpl(gh<_i125.ProfileRemoteDataSource>()),
    );
    gh.lazySingleton<_i828.CoursesRepository>(
      () => _i709.CoursesRepositoryImpl(gh<_i580.CoursesRemoteDataSource>()),
    );
    gh.lazySingleton<_i1027.AuthRemoteDataSource>(
      () => _i1027.AuthRemoteDataSourceImpl(
        gh<_i59.FirebaseAuth>(),
        gh<_i974.FirebaseFirestore>(),
      ),
    );
    gh.lazySingleton<_i932.GetMyCoursesUseCase>(
      () => _i932.GetMyCoursesUseCase(gh<_i677.MyCoursesRepository>()),
    );
    gh.lazySingleton<_i203.GetCoursesUseCase>(
      () => _i203.GetCoursesUseCase(gh<_i828.CoursesRepository>()),
    );
    gh.lazySingleton<_i154.RegisterCourseUseCase>(
      () => _i154.RegisterCourseUseCase(gh<_i828.CoursesRepository>()),
    );
    gh.lazySingleton<_i960.AuthRepository>(
      () => _i856.AuthRepositoryImpl(gh<_i1027.AuthRemoteDataSource>()),
    );
    gh.factory<_i547.MyCoursesBloc>(
      () => _i547.MyCoursesBloc(
        getMyCoursesUseCase: gh<_i932.GetMyCoursesUseCase>(),
      ),
    );
    gh.lazySingleton<_i473.GetProfileUseCase>(
      () => _i473.GetProfileUseCase(gh<_i304.ProfileRepository>()),
    );
    gh.lazySingleton<_i568.UpdateProfileUseCase>(
      () => _i568.UpdateProfileUseCase(gh<_i304.ProfileRepository>()),
    );
    gh.lazySingleton<_i883.GradesRepository>(
      () => _i215.GradesRepositoryImpl(gh<_i810.GradesRemoteDataSource>()),
    );
    gh.factory<_i956.CoursesBloc>(
      () => _i956.CoursesBloc(
        getCoursesUseCase: gh<_i203.GetCoursesUseCase>(),
        registerCourseUseCase: gh<_i154.RegisterCourseUseCase>(),
      ),
    );
    gh.lazySingleton<_i21.LoginUseCase>(
      () => _i21.LoginUseCase(gh<_i960.AuthRepository>()),
    );
    gh.lazySingleton<_i214.RegisterUseCase>(
      () => _i214.RegisterUseCase(gh<_i960.AuthRepository>()),
    );
    gh.factory<_i609.ProfileBloc>(
      () => _i609.ProfileBloc(
        getProfileUseCase: gh<_i473.GetProfileUseCase>(),
        updateProfileUseCase: gh<_i568.UpdateProfileUseCase>(),
      ),
    );
    gh.lazySingleton<_i230.GetGradesUseCase>(
      () => _i230.GetGradesUseCase(gh<_i883.GradesRepository>()),
    );
    gh.factory<_i940.AuthBloc>(
      () => _i940.AuthBloc(
        loginUseCase: gh<_i21.LoginUseCase>(),
        registerUseCase: gh<_i214.RegisterUseCase>(),
      ),
    );
    gh.factory<_i1000.GradesBloc>(
      () => _i1000.GradesBloc(getGradesUseCase: gh<_i230.GetGradesUseCase>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i868.RegisterModule {}
