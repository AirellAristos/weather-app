import 'package:geolocator/geolocator.dart';

class Location {
  // Private instance
  static final Location _instance = Location._internal();

  // Private constructor
  Location._internal();

  // Factory constructor mengembalikan instance yang memanggil private constructor
  factory Location() => _instance;

  // Cek permission dan ambil posisi saat ini
  Future<Position> getCurrentPosition() async{
    // Apakah gps/service lokasi aktif ?
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if(!serviceEnabled){
      throw Exception('Location services are disabled');
    }

    // Request permission buat akses lokasi
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied.');
    }

    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
    );

    // Mengembalikan berupa position
    return await Geolocator.getCurrentPosition(locationSettings: locationSettings);
  }
}