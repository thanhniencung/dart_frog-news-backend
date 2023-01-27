class User {
  User({this.fullName, this.email, this.password});
  String? fullName;
  String? email;
  String? password;

 Map<String, dynamic> toJson() => {
        'full_name': fullName,
        'email': email,
      };

  @override
  String toString() {
    return '{fullName = $fullName, email = $email, password = $password}';
  }
}
