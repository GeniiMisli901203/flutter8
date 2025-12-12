import '../interfaces/programm_datasource.dart';

abstract class GetProgrammUseCase {
  Future<dynamic> execute(String id);
}

class GetProgrammUseCaseImpl implements GetProgrammUseCase {
  final ProgrammDataSource _dataSource;

  GetProgrammUseCaseImpl(this._dataSource); // Конструктор с параметром

  @override
  Future<dynamic> execute(String id) async {
    return await _dataSource.getProgramm(id);
  }
}