class User {
  User({this.id, this.fullName, this.email, this.role, this.password});
  String? id;
  String? fullName;
  String? email;
  String? password;
  String? role;
  String? token;

  Map<String, dynamic> toJson() => {
        'id': id,
        'full_name': fullName,
        'email': email,
        'role': role,
        'token': token,
      };

  @override
  String toString() {
    return '''
      {id = $id, fullName = $fullName, email = $email, 
      role = $role password = $password, token = $token}
      ''';
  }
}
