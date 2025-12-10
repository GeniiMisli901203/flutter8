import '../models/programm.dart';

abstract class GetProgrammUseCase {
  Future<EducationProgram> execute(String programmId);
}

class GetProgrammUseCaseImpl implements GetProgrammUseCase {
  @override
  Future<EducationProgram> execute(String programmId) {
    // TODO: Implement use case logic
    throw UnimplementedError();
  }
}