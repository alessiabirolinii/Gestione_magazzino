import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

enum UserRole {
  admin,
  user,
}

@JsonSerializable()
class User {
  User({
    required this.code,
    required this.name,
    required this.surname,
    required this.email,
    required this.role,
  });

  final int code;
  final String name;
  final String surname;
  final String email;
  final UserRole role;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class UserRegisterDTO {
  UserRegisterDTO({
    required this.name,
    required this.surname,
    required this.email,
    required this.password,
  });

  @JsonKey(name: "nome")
  final String name;
  @JsonKey(name: "cognome")
  final String surname;
  final String email;
  final String password;

  factory UserRegisterDTO.fromJson(Map<String, dynamic> json) =>
      _$UserRegisterDTOFromJson(json);

  Map<String, dynamic> toJson() => _$UserRegisterDTOToJson(this);
}

@JsonSerializable()
class UserLoginDTO {
  UserLoginDTO({
    required this.password,
    required this.email,
  });

  final String password;
  final String email;

  factory UserLoginDTO.fromJson(Map<String, dynamic> json) =>
      _$UserLoginDTOFromJson(json);

  Map<String, dynamic> toJson() => _$UserLoginDTOToJson(this);
}
