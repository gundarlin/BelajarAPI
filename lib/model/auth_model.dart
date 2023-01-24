class AuthModel {
  int? id;
  String? name;
  String? email;
  String? password;
  String? password2;
  String? token;

  AuthModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.password2,
  });
}
