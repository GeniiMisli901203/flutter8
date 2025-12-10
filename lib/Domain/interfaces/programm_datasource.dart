import '';
import '../models/programm.dart';

abstract class ProgrammDataSource {
  Future<EducationProgram> getProgramm(String programmId);
  Future<List<EducationProgram>> getAllProgramms();
  Future<void> saveProgramm(EducationProgram programm);
}