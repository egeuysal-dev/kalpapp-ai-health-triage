class MonitoredPerson {
  final String id;
  final String fullName;
  final String relation;
  final int age;
  final String gender;
  final String deviceId;
  final int heartRate;
  final String status;
  final String lastMeasurement;
  final bool previousHeartAttack;
  final bool heartDisease;
  final bool hypertension;
  final bool diabetes;
  final bool highCholesterol;
  final bool smoking;
  final String medications;

  const MonitoredPerson({
    required this.id,
    required this.fullName,
    required this.relation,
    required this.age,
    required this.gender,
    required this.deviceId,
    required this.heartRate,
    required this.status,
    required this.lastMeasurement,
    required this.previousHeartAttack,
    required this.heartDisease,
    required this.hypertension,
    required this.diabetes,
    required this.highCholesterol,
    required this.smoking,
    required this.medications,
  });

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'relation': relation,
      'age': age,
      'gender': gender,
      'deviceId': deviceId,
      'heartRate': heartRate,
      'status': status,
      'lastMeasurement': lastMeasurement,
      'previousHeartAttack': previousHeartAttack,
      'heartDisease': heartDisease,
      'hypertension': hypertension,
      'diabetes': diabetes,
      'highCholesterol': highCholesterol,
      'smoking': smoking,
      'medications': medications,
    };
  }

  factory MonitoredPerson.fromMap(String id, Map<String, dynamic> map) {
    return MonitoredPerson(
      id: id,
      fullName: map['fullName'] ?? '',
      relation: map['relation'] ?? '',
      age: map['age'] ?? 0,
      gender: map['gender'] ?? '',
      deviceId: map['deviceId'] ?? '',
      heartRate: map['heartRate'] ?? 0,
      status: map['status'] ?? 'Bilinmiyor',
      lastMeasurement: map['lastMeasurement'] ?? '',
      previousHeartAttack: map['previousHeartAttack'] ?? false,
      heartDisease: map['heartDisease'] ?? false,
      hypertension: map['hypertension'] ?? false,
      diabetes: map['diabetes'] ?? false,
      highCholesterol: map['highCholesterol'] ?? false,
      smoking: map['smoking'] ?? false,
      medications: map['medications'] ?? '',
    );
  }

  MonitoredPerson copyWith({
    String? id,
    String? fullName,
    String? relation,
    int? age,
    String? gender,
    String? deviceId,
    int? heartRate,
    String? status,
    String? lastMeasurement,
    bool? previousHeartAttack,
    bool? heartDisease,
    bool? hypertension,
    bool? diabetes,
    bool? highCholesterol,
    bool? smoking,
    String? medications,
  }) {
    return MonitoredPerson(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      relation: relation ?? this.relation,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      deviceId: deviceId ?? this.deviceId,
      heartRate: heartRate ?? this.heartRate,
      status: status ?? this.status,
      lastMeasurement: lastMeasurement ?? this.lastMeasurement,
      previousHeartAttack: previousHeartAttack ?? this.previousHeartAttack,
      heartDisease: heartDisease ?? this.heartDisease,
      hypertension: hypertension ?? this.hypertension,
      diabetes: diabetes ?? this.diabetes,
      highCholesterol: highCholesterol ?? this.highCholesterol,
      smoking: smoking ?? this.smoking,
      medications: medications ?? this.medications,
    );
  }
}