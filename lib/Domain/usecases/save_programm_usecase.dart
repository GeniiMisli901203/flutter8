import '../models/programm.dart';
import '../interfaces/programm_datasource.dart';

abstract class SaveProgrammUseCase {
  Future<void> execute(EducationProgram programm);
}

class SaveProgrammUseCaseImpl implements SaveProgrammUseCase {
  final ProgrammDataSource _programmDataSource;

  SaveProgrammUseCaseImpl(this._programmDataSource);

  @override
  Future<void> execute(EducationProgram programm) {
    return _programmDataSource.saveProgramm(programm);
  }
}