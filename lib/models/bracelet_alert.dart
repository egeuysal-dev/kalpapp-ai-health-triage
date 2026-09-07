class BraceletAlert {
  final String id;
  final String personId;
  final String personName;
  final String deviceId;
  final String alertType;
  final int heartRate;
  final String message;
  final String createdAtText;

  const BraceletAlert({
    required this.id,
    required this.personId,
    required this.personName,
    required this.deviceId,
    required this.alertType,
    required this.heartRate,
    required this.message,
    required this.createdAtText,
  });

  Map<String, dynamic> toMap() {
    return {
      'personId': personId,
      'personName': personName,
      'deviceId': deviceId,
      'alertType': alertType,
      'heartRate': heartRate,
      'message': message,
      'createdAtText': createdAtText,
    };
  }

  factory BraceletAlert.fromMap(String id, Map<String, dynamic> map) {
    return BraceletAlert(
      id: id,
      personId: map['personId'] ?? '',
      personName: map['personName'] ?? '',
      deviceId: map['deviceId'] ?? '',
      alertType: map['alertType'] ?? '',
      heartRate: map['heartRate'] ?? 0,
      message: map['message'] ?? '',
      createdAtText: map['createdAtText'] ?? '',
    );
  }
}