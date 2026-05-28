import 'package:equatable/equatable.dart';
import '../../domain/entities/profile_entity.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class LoadProfile extends ProfileEvent {
  final String uid;

  const LoadProfile({required this.uid});

  @override
  List<Object?> get props => [uid];
}

class ProfileUpdated extends ProfileEvent {
  final ProfileEntity profile;

  const ProfileUpdated({required this.profile});

  @override
  List<Object?> get props => [profile];
}
