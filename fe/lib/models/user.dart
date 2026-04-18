class User {
  final int id;
  final String name;
  final String email;

  User({
    required this.id,
    required this.name,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }

  // For demo, fake users
  static List<User> fakeUsers = [
    User(id: 1, name: 'user1', email: 'user1@example.com'),
    User(id: 2, name: 'user2', email: 'user2@example.com'),
  ];
}