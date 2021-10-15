import 'dart:convert';

List<LocationModel> locationsListFromJson(String str) =>
    List<LocationModel>.from(
        json.decode(str).map((x) => LocationModel.fromJson(x)));

class LocationModel {
  final dynamic locationName, description, latitude, longitude;

  LocationModel(
      {this.locationName, this.description, this.latitude, this.longitude});

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
      description: json["description"],
      locationName: json["location_name"],
      latitude: double.parse(json["latitude"]),
      longitude: double.parse(json["longitude"]));
}
