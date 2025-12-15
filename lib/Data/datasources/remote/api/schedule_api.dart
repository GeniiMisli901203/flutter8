// lib/Data/datasources/remote/api/schedule_api.dart
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'schedule_api.g.dart';

@RestApi(baseUrl: "http://127.0.0.1:8080")
abstract class ScheduleApi {
  factory ScheduleApi(Dio dio, {String baseUrl}) = _ScheduleApi;

  @GET('/schedule')
  Future<dynamic> getAllSchedules();

  @GET('/schedule/{day}')
  Future<dynamic> getScheduleByDay(@Path('day') String day);

  @GET('/{className}/{day}')
  Future<dynamic> getScheduleByClassAndDay(
      @Path('className') String className,
      @Path('day') String day,
      );

  @POST('/schedule/create')
  Future<dynamic> createSchedule(@Body() Map<String, dynamic> request);

  @DELETE('/{scheduleId}')
  Future<dynamic> deleteSchedule(@Path('scheduleId') String scheduleId);
}