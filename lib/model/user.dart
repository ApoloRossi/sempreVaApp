class User {
  final int userId;
  final String name;
  final String password;
  final String email;

  const User({
    required this.userId,
    required this.name,
    required this.password,
    required this.email
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['id'],
      name: json['name'],
      password: json['password'],
      email: json['email']
    );
  }

}