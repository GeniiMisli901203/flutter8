// lib/Data/datasources/remote/api/user_api.dart
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'user_api.g.dart';

@RestApi(baseUrl: "(baseUrl)") // Изменено с фиксированного URL
abstract class UserApi {
  factory UserApi(Dio dio, {String baseUrl}) = _UserApi;

  @GET('/user/info')
  Future<dynamic> getUserInfo();

  @GET('/user/{login}')
  Future<dynamic> getUserByLogin(@Path('login') String login);

  @PUT('/user/{login}')
  Future<dynamic> updateUser(
      @Path('login') String login,
      @Body() Map<String, dynamic> request,
      );

  @DELETE('/user/{email}')
  Future<dynamic> deleteUser(@Path('email') String email);
}