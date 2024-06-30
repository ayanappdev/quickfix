import 'package:shared_preferences/shared_preferences.dart';

class LocationPreferences {
  static const _keyLatitude = 'latitude';
  static const _keyLongitude = 'longitude';

  Future<void> saveLocation(double latitude, double longitude) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_keyLatitude, latitude);
    await prefs.setDouble(_keyLongitude, longitude);
  }

  Future<Map<String, double?>> getLocation() async {
    final prefs = await SharedPreferences.getInstance();
    final latitude = prefs.getDouble(_keyLatitude);
    final longitude = prefs.getDouble(_keyLongitude);
    return {'latitude': latitude, 'longitude': longitude};
  }
}
