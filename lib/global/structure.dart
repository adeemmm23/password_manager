class Collection {
  late final String name;
  late final List<Account> accounts;

  Collection({
    required this.name,
    required this.accounts,
  });

  Collection.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    accounts =
        (map['accounts'] as List).map((e) => Account.fromMap(e)).toList();
  }
}

class Account {
  late final String username;
  late final String password;
  final createdAt = DateTime.now();
  final updatedAt = DateTime.now();

  Account({
    required this.username,
    required this.password,
  });

  Account.fromMap(Map<String, dynamic> map) {
    username = map['username'];
    password = map['password'];
  }

  bool isExpired() {
    return DateTime.now().difference(updatedAt).inDays > 30;
  }
}
