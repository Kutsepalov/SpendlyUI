class User {
  String? name;
  String? surname;
  String? currency;
  String? email;
  String? username;

  User({
    this.name,
    this.surname,
    this.currency,
    this.email,
    this.username,
  });

  factory User.fromJson(dynamic json) {
    return User(
      name: json['name'],
      currency: json['currency'],
      email: json['email'],
      surname: json['surname'],
      username: json['username'],
    );
  }

  String getFullName() {
    return '$name $surname';
  }

  String getInitials() {
    return '${name!.substring(0, 1)}${surname!.substring(0, 1)}';
  }
}
