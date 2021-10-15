import 'package:hoplist_app/features/locations/data/models/location_model.dart';

abstract class LocationRemoteInterface {
  Future<List<LocationModel>> getAllLocations();
}
