import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import '../models/point.dart';

class PointController {
  // Workplace coordinates (example). Replace with the real workplace latitude/longitude.
  static const double workplaceLat = -23.550520; // São Paulo example
  static const double workplaceLon = -46.633308;
  static const double allowedMeters = 100.0;

  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<Position> _getCurrentPosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied');
    }
  // Use LocationSettings instead of deprecated desiredAccuracy parameter
  return await Geolocator.getCurrentPosition(locationSettings: const LocationSettings(accuracy: LocationAccuracy.best));
  }

  static double _distanceMeters(double lat1, double lon1, double lat2, double lon2) {
    return Geolocator.distanceBetween(lat1, lon1, lat2, lon2);
  }

  static Future<PointModel> registerPoint({required String nif}) async {
    final pos = await _getCurrentPosition();
    final distance = _distanceMeters(pos.latitude, pos.longitude, workplaceLat, workplaceLon);
    final allowed = distance <= allowedMeters;

    final point = PointModel(
      nif: nif,
      timestamp: DateTime.now().toUtc(),
      latitude: pos.latitude,
      longitude: pos.longitude,
      distanceMeters: distance,
      allowed: allowed,
    );

    await _db.collection('points').add(point.toMap());
    return point;
  }
}
