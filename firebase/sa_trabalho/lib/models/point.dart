class PointModel {
  final String nif;
  final DateTime timestamp;
  final double latitude;
  final double longitude;
  final double distanceMeters;
  final bool allowed;

  PointModel({required this.nif, required this.timestamp, required this.latitude, required this.longitude, required this.distanceMeters, required this.allowed});

  Map<String, dynamic> toMap() => {
        'nif': nif,
        'timestamp': timestamp.toIso8601String(),
        'latitude': latitude,
        'longitude': longitude,
        'distanceMeters': distanceMeters,
        'allowed': allowed,
      };

  factory PointModel.fromMap(Map<String, dynamic> map) {
    return PointModel(
      nif: map['nif'] as String,
      timestamp: DateTime.parse(map['timestamp'] as String),
      latitude: (map['latitude'] as num).toDouble(),
      longitude: (map['longitude'] as num).toDouble(),
      distanceMeters: (map['distanceMeters'] as num).toDouble(),
      allowed: map['allowed'] as bool,
    );
  }
}
