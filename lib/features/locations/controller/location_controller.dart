import 'package:get/get.dart';
import 'package:hoplist_app/core/exceptions/exception.dart';
import 'package:hoplist_app/features/locations/data/models/location_model.dart';
import 'package:hoplist_app/features/locations/data/repositories/location_remote_impl.dart';
import 'package:hoplist_app/features/locations/data/repositories/location_remote_interface.dart';

class LocationController extends GetxController {
  LocationRemoteInterface repo = LocationRemoteImpl();

  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var allLocations = <LocationModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getAllLocations();
  }

  Future<void> getAllLocations() async {
    try {
      isLoading(true);
      errorMessage('');
      var retrievedLocations = await repo.getAllLocations();
      isLoading(false);
      errorMessage('');
      allLocations(retrievedLocations);
    } on GeneralException catch (e) {
      isLoading(false);
      errorMessage(e.message);
    } on NetworkException catch (e) {
      isLoading(false);
      errorMessage(e.message);
    } finally {
      isLoading(false);
    }
  }
}
