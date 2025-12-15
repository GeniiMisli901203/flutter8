import '../../../../../domain/interfaces/auth_datasource.dart';
import '../dto/api/login_dto.dart';
import '../dto/api/registration_dto.dart';
import 'dio_client.dart';
import 'exceptions/network_exception.dart';


class AuthRemoteDataSource implements AuthDataSource {
  final DioClient _dioClient;

  AuthRemoteDataSource(this._dioClient);

  Future<void> register({
    required String login,
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String className,
    required String school,
  }) async {
    try {
      final request = RegistrationRequestDTO(
        login: login,
        email: email,
        password: password,
        userName: firstName,
        userSName: lastName,
        userClass: className,
        userSchool: school,
      );

      final response = await _dioClient.post<Map<String, dynamic>>(
        '/register',
        data: request.toJson(),
      );

      if (response.statusCode != 201) {
        final errorMessage = response.data is Map
            ? (response.data as Map).toString()
            : 'Неизвестная ошибка';
        throw NetworkException('Ошибка регистрации: $errorMessage');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> login(String login, String password) async {
    try {
      final request = LoginRequestDTO(login: login, password: password);
      final response = await _dioClient.post<Map<String, dynamic>>(
        '/login',
        data: request.toJson(),
      );

      if (response.statusCode == 200) {
        final loginResponse = LoginResponseDTO.fromJson(response.data!);
        return loginResponse.token;
      } else {
        throw UnauthorizedException('Неверные учетные данные');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> saveLoginInfo(String token) async {
    // Этот метод должен сохранять токен локально
    // Реализация будет в классе-адаптере
    throw UnimplementedError('Use local implementation for saving token');
  }

  @override
  Future<String?> getLoginInfo() async {
    // Этот метод должен получать токен локально
    // Реализация будет в классе-адаптере
    throw UnimplementedError('Use local implementation for getting token');
  }

  @override
  Future<void> clearLoginInfo() async {
    // Этот метод должен очищать токен локально
    // Реализация будет в классе-адаптере
    throw UnimplementedError('Use local implementation for clearing token');
  }


}