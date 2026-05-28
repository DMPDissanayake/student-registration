import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

@lazySingleton
class RegisterUseCase implements UseCase<UserEntity, RegisterParams> {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(RegisterParams params) async {
    return await repository.register(
      name: params.name,
      email: params.email,
      password: params.password,
      studentId: params.studentId,
      phone: params.phone,
      address: params.address,
    );
  }
}

class RegisterParams extends Equatable {
  final String name;
  final String email;
  final String password;
  final String studentId;
  final String phone;
  final String address;

  const RegisterParams({
    required this.name,
    required this.email,
    required this.password,
    required this.studentId,
    required this.phone,
    required this.address,
  });

  @override
  List<Object?> get props => [name, email, password, studentId, phone, address];
}
