import '../../../Domain/interfaces/programm_datasource.dart';
import '../../../Domain/models/programm.dart';


class ProgrammApiDataSource implements ProgrammDataSource {
  @override
  Future<EducationProgram> getProgramm(String programmId) {
    // TODO: Implement API call to get programm
    throw UnimplementedError();
  }

  @override
  Future<List<EducationProgram>> getAllProgramms() {
    // TODO: Implement API call to get all programms
    throw UnimplementedError();
  }

  @override
  Future<void> saveProgramm(EducationProgram programm) {
    // TODO: Implement API call to save programm
    throw UnimplementedError();
  }
}