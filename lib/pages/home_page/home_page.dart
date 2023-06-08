import 'package:flutter/material.dart';
import 'package:openbeta/models/climbing_route.dart';
import 'package:openbeta/services/climb_service.dart';
import 'package:openbeta/services/area_service.dart';
import 'package:openbeta/services/test_connection_service.dart';
import 'package:openbeta/services/local_database_service.dart';
import 'package:openbeta/services/get_user_location_service.dart';
import 'package:graphql/client.dart';
import 'package:openbeta/pages/nearby_areas_page/helpers/nearby_areas_helper.dart';

import 'widgets/search_bar.dart';
import 'widgets/nearby_areas_button.dart';
import 'widgets/nearby_areas.dart';
import 'widgets/app_bar/app_bar.dart';
import 'widgets/climbing_routes_list_view.dart';
import 'package:openbeta/pages/regions.dart'; // Import the regions page

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HttpLink httpLink;
  late ClimbService climbService;
  late AreaService areaService;
  late TestConnectionService testConnectionService;
  final LocalDatabase localDatabase = LocalDatabase.instance;
  final LocationService locationService = LocationService();
  late TextEditingController _apiController;
  late TextEditingController _localController;
  Future<List<ClimbingRoute>>? _apiSearchResult;
  Future<List<ClimbingRoute>>? _localSearchResult;
  List<String>? _nearbyAreas;
  bool _isSwitched = true;

  @override
  void initState() {
    super.initState();
    httpLink = HttpLink('https://api.openbeta.io/graphql');
    climbService = ClimbService(httpLink);
    areaService = AreaService(httpLink);
    testConnectionService = TestConnectionService(httpLink);
    _initializeControllers();
  }

  void _initializeControllers() {
    _apiController = TextEditingController();
    _localController = TextEditingController();
  }

  void _searchApi() {
    setState(() {
      _apiSearchResult = climbService.getClimbsForArea(_apiController.text);
    });
    _apiController.clear();
  }

  void _searchLocal() {
    setState(() {
      _localSearchResult = localDatabase.searchRoutes(_localController.text);
    });
    _localController.clear();
  }

  void _getNearbyAreas() async {
    final nearbyAreasHelper = NearbyAreasHelper(
      locationService: locationService,
      areaService: areaService,
      context: context,
    );
    await nearbyAreasHelper.getNearbyAreas();
  }

  void _navigateToRegionsPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegionPage()),
    );
  }

  void _dismissKeyboard() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _dismissKeyboard,
      child: Scaffold(
        appBar: AppBarWidget(),
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            children: [
              CustomSearchBar(
                labelText: _isSwitched ? 'Search API' : 'Search Local',
                controller: _isSwitched ? _apiController : _localController,
                onPressed: _isSwitched ? _searchApi : _searchLocal,
                isSwitched: _isSwitched,
                onSwitched: (value) {
                  setState(() {
                    _isSwitched = value;
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  Button(
                    text: 'Regions',
                    icon: Icons.location_on,
                    onPressed: _navigateToRegionsPage,
                  ),
                  Button(
                    text: 'Areas Near Me',
                    icon: Icons.near_me,
                    onPressed: _getNearbyAreas,
                  ),
                ],
              ),
              if (_nearbyAreas != null) NearbyAreas(areas: _nearbyAreas!),
              Expanded(
                child: FutureBuilder<List<ClimbingRoute>>(
                  future: _apiSearchResult,
                  builder: (context, snapshot) {
                    return ClimbingRoutesListView(snapshot: snapshot);
                  },
                ),
              ),
              Expanded(
                child: FutureBuilder<List<ClimbingRoute>>(
                  future: _localSearchResult,
                  builder: (context, snapshot) {
                    return ClimbingRoutesListView(snapshot: snapshot);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  const Button({
    required this.text,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.black),
      label: Text(
        text,
        style: TextStyle(color: Colors.black),
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
