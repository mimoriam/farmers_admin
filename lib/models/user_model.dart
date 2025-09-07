class UserModel {
  final String id;
  final String fullName;
  final String email;
  final String dob;
  final String status;
  final String? phone;
  final String? gender;

  UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.dob,
    required this.status,
    this.phone,
    this.gender,
  });

  // Factory constructor to create a UserModel from a map (Firebase data)
  factory UserModel.fromMap(String id, Map<dynamic, dynamic> map) {
    return UserModel(
      id: id,
      fullName: map['fullName'] ?? 'N/A',
      email: map['email'] ?? 'N/A',
      dob: map['dob'] ?? 'N/A',
      status: map['status'] ?? 'N/A',
      phone: map['phone'],
      gender: map['gender'],
    );
  }
}
