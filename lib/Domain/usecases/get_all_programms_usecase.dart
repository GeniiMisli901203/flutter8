
import 'package:flutter5/Domain/models/programm.dart';

import '../interfaces/programm_datasource.dart';

abstract class GetAllProgrammsUseCase {
  Future<List<EducationProgram>> execute();
}

class GetAllProgrammsUseCaseImpl implements GetAllProgrammsUseCase {
  final ProgrammDataSource _programmDataSource;

  GetAllProgrammsUseCaseImpl(this._programmDataSource);

  @override
  Future<List<EducationProgram>> execute() {
    return _programmDataSource.getAllProgramms();
  }
}