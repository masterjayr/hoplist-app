import 'dart:convert';

import 'package:get/get.dart';
import 'package:hoplist_app/core/api_endpoints.dart';
import 'package:hoplist_app/core/exceptions/exception.dart';
import 'package:hoplist_app/core/local_repository/local_repository_impl.dart';
import 'package:hoplist_app/features/locations/data/models/location_model.dart';
import 'package:hoplist_app/features/locations/data/repositories/location_remote_interface.dart';

class LocationRemoteImpl extends GetConnect implements LocationRemoteInterface {
  UserLocalRepositoryImpl localRepositoryImpl = UserLocalRepositoryImpl();

  @override
  Future<List<LocationModel>> getAllLocations() async {
    if (await localRepositoryImpl.isNetworkConnected) {
      final Response response = await get('$BASE_URL$GET_LOCATIONS');
      if (response.statusCode == 200) {
        return locationsListFromJson(json.encode(response.body["data"]));
      } else {
        throw GeneralException(message: "A general error occurred");
      }
    } else {
      throw NetworkException(message: "Please check your network connection");
    }
  }
}
