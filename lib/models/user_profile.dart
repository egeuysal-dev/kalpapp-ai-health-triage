class UserProfile {
  final String fullName;
  final int age;
  final String gender;
  final bool previousHeartAttack;
  final bool heartDisease;
  final bool hypertension;
  final bool diabetes;
  final bool highCholesterol;
  final bool smoking;
  final String medications;

  final String emergencyContactName;
  final String emergencyContactPhone;
  final String emergencyContactRelation;

  const UserProfile({
    required this.fullName,
    required this.age,
    required this.gender,
    required this.previousHeartAttack,
    required this.heartDisease,
    required this.hypertension,
    required this.diabetes,
    required this.highCholesterol,
    required this.smoking,
    required this.medications,
    required this.emergencyContactName,
    required this.emergencyContactPhone,
    required this.emergencyContactRelation,
  });

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'age': age,
      'gender': gender,
      'previousHeartAttack': previousHeartAttack,
      'heartDisease': heartDisease,
      'hypertension': hypertension,
      'diabetes': diabetes,
      'highCholesterol': highCholesterol,
      'smoking': smoking,
      'medications': medications,
      'emergencyContactName': emergencyContactName,
      'emergencyContactPhone': emergencyContactPhone,
      'emergencyContactRelation': emergencyContactRelation,
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      fullName: map['fullName'] ?? '',
      age: map['age'] ?? 0,
      gender: map['gender'] ?? 'Erkek',
      previousHeartAttack: map['previousHeartAttack'] ?? false,
      heartDisease: map['heartDisease'] ?? false,
      hypertension: map['hypertension'] ?? false,
      diabetes: map['diabetes'] ?? false,
      highCholesterol: map['highCholesterol'] ?? false,
      smoking: map['smoking'] ?? false,
      medications: map['medications'] ?? '',
      emergencyContactName: map['emergencyContactName'] ?? '',
      emergencyContactPhone: map['emergencyContactPhone'] ?? '',
      emergencyContactRelation: map['emergencyContactRelation'] ?? '',
    );
  }
}