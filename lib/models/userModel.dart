class UserModel {
  int id;
  String emailAddress;
  String? phone;
  String? username;
  String role;
  String? firstname;
  String? lastname;
  String password;

  UserModel(
      {required this.id,
      required this.emailAddress,
      required this.phone,
      required this.username,
      required this.role,
      required this.firstname,
      required this.lastname,
      required this.password});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      emailAddress: map['emailAddress'],
      phone: map['phone'],
      username: map['username'],
      role: map['role'],
      firstname: map['firstname'],
      lastname: map['lastname'],
      password: map['password'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'emailAddress': emailAddress,
      'phone': phone,
      'username': username,
      'role': role,
      'firstname': firstname,
      'lastname': lastname,
      'password': password,
    };
  }
}
