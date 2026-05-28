import 'package:equatable/equatable.dart';
import '../../domain/entities/registration_entity.dart';

abstract class MyCoursesState extends Equatable {
  const MyCoursesState();

  @override
  List<Object?> get props => [];
}

class MyCoursesInitial extends MyCoursesState {}

class MyCoursesLoading extends MyCoursesState {}

class MyCoursesLoaded extends MyCoursesState {
  final List<RegistrationEntity> registrations;

  const MyCoursesLoaded({required this.registrations});

  @override
  List<Object?> get props => [registrations];
}

class MyCoursesError extends MyCoursesState {
  final String message;

  const MyCoursesError({required this.message});

  @override
  List<Object?> get props => [message];
}
