class UserModel {
  String id;
  String firstName;
  String lastName;
  String email;

  int loginTimestamp;
  String studentId;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.loginTimestamp,
    this.studentId = "",
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      loginTimestamp: json['loginTimestamp'],
      studentId:
          json['studentId'] ?? "", // Default to empty string if not present
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'loginTimestamp': loginTimestamp,
      'studentId': studentId,
    };
  }
}
