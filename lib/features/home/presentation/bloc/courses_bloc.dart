import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/get_courses_usecase.dart';
import '../../domain/usecases/register_course_usecase.dart';
import 'courses_event.dart';
import 'courses_state.dart';

@injectable
class CoursesBloc extends Bloc<CoursesEvent, CoursesState> {
  final GetCoursesUseCase _getCoursesUseCase;
  final RegisterCourseUseCase _registerCourseUseCase;

  CoursesBloc({
    required GetCoursesUseCase getCoursesUseCase,
    required RegisterCourseUseCase registerCourseUseCase,
  }) : _getCoursesUseCase = getCoursesUseCase,
       _registerCourseUseCase = registerCourseUseCase,
       super(CoursesInitial()) {
    on<FetchCourses>(_onFetchCourses);
    on<RegisterInCourse>(_onRegisterInCourse);
  }

  Future<void> _onFetchCourses(
    FetchCourses event,
    Emitter<CoursesState> emit,
  ) async {
    emit(CoursesLoading());
    final result = await _getCoursesUseCase(NoParams());
    result.fold(
      (failure) => emit(CoursesError(message: failure.message)),
      (courses) => emit(CoursesLoaded(courses: courses)),
    );
  }

  Future<void> _onRegisterInCourse(
    RegisterInCourse event,
    Emitter<CoursesState> emit,
  ) async {
    emit(CoursesLoading());
    final result = await _registerCourseUseCase(
      CourseRegistrationParams(userId: event.userId, courseId: event.courseId),
    );
    result.fold(
      (failure) => emit(CoursesError(message: failure.message)),
      (_) => emit(
        const CourseRegistrationSuccess(
          message: 'Successfully registered for the course!',
        ),
      ),
    );
  }
}
