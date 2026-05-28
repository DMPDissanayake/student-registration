import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final String uid;
  final String name;
  final String email;
  final String studentId;
  final String phone;
  final String address;

  const ProfileEntity({
    required this.uid,
    required this.name,
    required this.email,
    required this.studentId,
    required this.phone,
    required this.address,
  });

  @override
  List<Object?> get props => [uid, name, email, studentId, phone, address];
}
