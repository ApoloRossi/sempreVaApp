class User {
  final int userId;
  final String name;

  const User({
    required this.userId,
    required this.name
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['id'],
      name: json['name'],
    );
  }

}