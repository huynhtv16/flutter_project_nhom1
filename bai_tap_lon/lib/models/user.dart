class User {
  final String username;
  final String password; // In real app, this should be hashed

  User({required this.username, required this.password});

  // For demo, fake users
  static List<User> fakeUsers = [
    User(username: 'user1', password: 'pass1'),
    User(username: 'user2', password: 'pass2'),
  ];
}