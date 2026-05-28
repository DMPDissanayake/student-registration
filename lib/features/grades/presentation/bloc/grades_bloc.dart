import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/usecases/get_grades_usecase.dart';
import 'grades_event.dart';
import 'grades_state.dart';

@injectable
class GradesBloc extends Bloc<GradesEvent, GradesState> {
  final GetGradesUseCase _getGradesUseCase;

  GradesBloc({required GetGradesUseCase getGradesUseCase})
    : _getGradesUseCase = getGradesUseCase,
      super(GradesInitial()) {
    on<FetchGrades>(_onFetchGrades);
  }

  Future<void> _onFetchGrades(
    FetchGrades event,
    Emitter<GradesState> emit,
  ) async {
    emit(GradesLoading());
    final result = await _getGradesUseCase(event.userId);
    result.fold(
      (failure) => emit(GradesError(message: failure.message)),
      (grades) => emit(GradesLoaded(grades: grades)),
    );
  }
}
