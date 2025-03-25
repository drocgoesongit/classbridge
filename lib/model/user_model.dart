class UserModel {
  String id;
  String firstName;
  String lastName;
  String email;

  int loginTimestamp;


  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,

    required this.loginTimestamp,

  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      loginTimestamp: json['loginTimestamp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'loginTimestamp': loginTimestamp,
    };
  }
}
