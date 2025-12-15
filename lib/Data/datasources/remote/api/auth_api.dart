// lib/Data/datasources/remote/api/auth_api.dart
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_api.g.dart';

@RestApi(baseUrl: "(baseUrl)")
abstract class AuthApi {
  factory AuthApi(Dio dio, {String baseUrl}) = _AuthApi;

  @POST('/register')
  Future<dynamic> register(@Body() Map<String, dynamic> request);

  @POST('/login')
  Future<dynamic> login(@Body() Map<String, dynamic> request);
}