// БЫЛО:
import 'package:flutter5/Data/datasources/remote/api/user_remote_data_source.dart';
import 'package:flutter5/Domain/interfaces/secure_user_datasource.dart';

import '../entities/user_profile.dart';

// СТАЛО (если файл находится внутри Domain):
import '../entities/user_profile.dart'; // Это правильный путь

// ИЛИ если есть ошибка, попробуйте:
import '../../Domain/entities/user_profile.dart';
class UpdateUserProfileUseCase {
  final UserRemoteDataSource _remoteDataSource;
  final SecureUserDataSource _localDataSource;

  UpdateUserProfileUseCase({
    required UserRemoteDataSource remoteDataSource,
    required SecureUserDataSource localDataSource,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  Future<void> execute(String login, UserProfile updatedProfile) async {
    try {
      await _remoteDataSource.updateUser(login, updatedProfile);
      final data = updatedProfile.toMap();
      for (final entry in data.entries) {
        await _localDataSource.saveUserData(entry.key, entry.value);
      }
      await _localDataSource.saveUserData('lastUpdated', DateTime.now().toIso8601String());
    } catch (e) {
      rethrow;
    }
  }
}