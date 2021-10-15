import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hoplist_app/features/locations/controller/location_controller.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  LocationController locationController = Get.put(LocationController());
  GoogleMapController? mapController;
  List<Marker> _markers = [];
  void initMarker(
      String description, dynamic lat, dynamic long, String address) async {
    _markers.add(Marker(
        markerId: MarkerId(description),
        position: LatLng(lat, long),
        infoWindow: InfoWindow(title: address),
        icon: BitmapDescriptor.defaultMarker));
  }

  var currentLocation;
  Completer<GoogleMapController> _controller = Completer();
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  void initState() {
    super.initState();
    Geolocator.getCurrentPosition().then((value) {
      setState(() {
        currentLocation = value;
        _markers.add(Marker(
            markerId: MarkerId('myMarker'),
            position:
                LatLng(currentLocation.longitude, currentLocation.latitude),
            infoWindow: InfoWindow(title: 'My Location'),
            icon: BitmapDescriptor.defaultMarker));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Locations"),
          backgroundColor: Colors.blue,
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Obx(() {
          if (locationController.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (locationController.errorMessage.value != '') {
            return Center(
              child: Text(locationController.errorMessage.value),
            );
          } else {
            for (var location in locationController.allLocations) {
              Get.log("Location ${location.locationName}");
              initMarker(location.description, location.latitude,
                  location.longitude, location.locationName);
            }

            return GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(
                      currentLocation.latitude, currentLocation.longitude),
                  zoom: 5),
              onMapCreated: _onMapCreated,

              myLocationEnabled:
                  true, // Add little blue dot for device location, requires permission from user
              mapType: MapType.normal,
              markers: Set.from(_markers),
            );
          }
        }));
  }
}
