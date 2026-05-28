import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/usecases/get_my_courses_usecase.dart';
import 'my_courses_event.dart';
import 'my_courses_state.dart';

@injectable
class MyCoursesBloc extends Bloc<MyCoursesEvent, MyCoursesState> {
  final GetMyCoursesUseCase _getMyCoursesUseCase;

  MyCoursesBloc({required GetMyCoursesUseCase getMyCoursesUseCase})
    : _getMyCoursesUseCase = getMyCoursesUseCase,
      super(MyCoursesInitial()) {
    on<FetchMyCourses>(_onFetchMyCourses);
  }

  Future<void> _onFetchMyCourses(
    FetchMyCourses event,
    Emitter<MyCoursesState> emit,
  ) async {
    emit(MyCoursesLoading());
    final result = await _getMyCoursesUseCase(event.userId);
    result.fold(
      (failure) => emit(MyCoursesError(message: failure.message)),
      (registrations) => emit(MyCoursesLoaded(registrations: registrations)),
    );
  }
}
