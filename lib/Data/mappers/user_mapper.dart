import '../../Domain/entities/user_profile.dart';
import '../datasources/remote/dto/api/user_dto.dart';


class UserMapper {
  static UserProfile fromResponseDTO(UserResponseDTO dto) {
    return UserProfile(
      firstName: dto.name,
      lastName: dto.sName,
      email: dto.email,
      phone: '',
      school: dto.school,
      className: dto.uClass,
      login: dto.userId,
    );
  }

  static UpdateUserRequestDTO toUpdateRequestDTO(UserProfile profile) {
    return UpdateUserRequestDTO(
      name: profile.firstName,
      sName: profile.lastName,
      uClass: profile.className,
      school: profile.school,
    );
  }

  static UserResponseDTO toResponseDTO(UserProfile profile) {
    return UserResponseDTO(
      userId: profile.login,
      email: profile.email,
      name: profile.firstName,
      sName: profile.lastName,
      uClass: profile.className,
      school: profile.school,
    );
  }
}