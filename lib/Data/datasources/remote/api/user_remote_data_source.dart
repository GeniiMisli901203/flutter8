import 'package:flutter5/Data/mappers/user_mapper.dart';

import '../../../../Domain/entities/user_profile.dart';
import '../dto/api/user_dto.dart';
import 'dio_client.dart';
import 'exceptions/network_exception.dart';

class UserRemoteDataSource {
  final DioClient _dioClient;

  UserRemoteDataSource(this._dioClient);

  Future<UserProfile> getUserInfo() async {
    try {
      final response = await _dioClient.get<Map<String, dynamic>>('/user/info');

      if (response.statusCode == 200) {
        final userInfoResponse = UserInformationResponseDTO.fromJson(response.data!);

        if (userInfoResponse.success && userInfoResponse.user != null) {
          return UserMapper.fromResponseDTO(userInfoResponse.user!);
        } else {
          throw NotFoundException(userInfoResponse.message ?? 'Пользователь не найден');
        }
      } else {
        throw NetworkException('Ошибка получения данных пользователя');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<UserProfile> getUserByLogin(String login) async {
    try {
      final response = await _dioClient.get<Map<String, dynamic>>('/user/$login');

      if (response.statusCode == 200) {
        final userInfoResponse = UserInformationResponseDTO.fromJson(response.data!);

        if (userInfoResponse.success && userInfoResponse.user != null) {
          return UserMapper.fromResponseDTO(userInfoResponse.user!);
        } else {
          throw NotFoundException(userInfoResponse.message ?? 'Пользователь не найден');
        }
      } else {
        throw NetworkException('Ошибка получения данных пользователя');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateUser(String login, UserProfile updatedProfile) async {
    try {
      final request = UserMapper.toUpdateRequestDTO(updatedProfile);

      final response = await _dioClient.put<Map<String, dynamic>>(
        '/user/$login',
        data: request.toJson(),
      );

      if (response.statusCode == 200) {
        final updateResponse = UserInformationResponseDTO.fromJson(response.data!);

        if (!updateResponse.success) {
          throw NetworkException(updateResponse.message ?? 'Ошибка обновления данных');
        }
      } else {
        throw NetworkException('Ошибка обновления данных пользователя');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteUser(String email) async {
    try {
      final response = await _dioClient.delete<Map<String, dynamic>>('/user/$email');

      if (response.statusCode == 200) {
        final deleteResponse = UserInformationResponseDTO.fromJson(response.data!);

        if (!deleteResponse.success) {
          throw NetworkException(deleteResponse.message ?? 'Ошибка удаления пользователя');
        }
      } else {
        throw NetworkException('Ошибка удаления пользователя');
      }
    } catch (e) {
      rethrow;
    }
  }
}