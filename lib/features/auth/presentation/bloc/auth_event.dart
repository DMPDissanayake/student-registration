import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class LoginSubmitted extends AuthEvent {
  final String email;
  final String password;

  const LoginSubmitted({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class RegisterSubmitted extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final String studentId;
  final String phone;
  final String address;

  const RegisterSubmitted({
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
