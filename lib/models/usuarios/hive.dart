import 'package:hive/hive.dart';
//part 'hive.g.dart';

@HiveType(typeId: 1)
class Hive {
  Hive({
    required this.email,
    required this.senha,
    required this.rememberMe,
  });

  @HiveField(0)
  String email;
  @HiveField(1)
  String senha;
  @HiveField(2)
  bool rememberMe;

  // factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
  //       email: json["email"],
  //       senha: json["senha"],
  //       rememberMe: json["rememberMe"],
  //     );

  // Map<String, dynamic> toJson() => {
  //       "email": email,
  //       "senha": senha,
  //       "rememberMe": rememberMe,
  //     };
}