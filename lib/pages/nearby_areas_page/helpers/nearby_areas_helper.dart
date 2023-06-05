import 'package:flutter/material.dart';
import 'package:openbeta/services/area_service.dart';
import 'package:openbeta/services/get_user_location_service.dart';
import 'package:openbeta/pages/nearby_areas_page/nearby_areas_page.dart';

class NearbyAreasHelper {
  final LocationService locationService;
  final AreaService areaService;
  final BuildContext context;

  NearbyAreasHelper({
    required this.locationService,
    required this.areaService,
    required this.context,
  });

  Future<void> getNearbyAreas() async {
    final location = await locationService.getCurrentLocation();
    if (location != null) {
      final areas = await areaService.getNearbyAreas(location.latitude, location.longitude);
      if (areas != null && areas.isNotEmpty) {
        print('Nearby Areas: $areas');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NearbyAreasPage(areas: areas),
          ),
        );
      } else {
        print('No nearby areas found.');
      }
    }
  }
}
