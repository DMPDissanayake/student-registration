import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/constants/firebase_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel> getProfile(String uid);
  Future<ProfileModel> updateProfile(ProfileModel profile);
}

@LazySingleton(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final FirebaseFirestore firestore;

  ProfileRemoteDataSourceImpl(this.firestore);

  @override
  Future<ProfileModel> getProfile(String uid) async {
    try {
      final doc = await firestore
          .collection(FirebaseConstants.usersCollection)
          .doc(uid)
          .get();
      if (!doc.exists) {
        throw const ServerException('Profile not found.');
      }
      return ProfileModel.fromFirestore(doc);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<ProfileModel> updateProfile(ProfileModel profile) async {
    try {
      await firestore
          .collection(FirebaseConstants.usersCollection)
          .doc(profile.uid)
          .update(profile.toFirestore());
      return profile;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
