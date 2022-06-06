class User {
  final int id;
  final String name;
  final String username;
  final String password;
  final String nohp;
  final String email;
  final String role_id;

  const User({
    required this.id,
    required this.name,
    required this.username,
    required this.password,
    required this.nohp,
    required this.email,
    required this.role_id,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
      nohp: json['nohp'] as String,
      email: json['email'] as String,
      role_id: json['role_id'] as String,
    );
  }
}
