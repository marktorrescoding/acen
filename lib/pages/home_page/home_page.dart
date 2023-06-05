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
      MaterialPageRoute(builder: (context) => RegionPage()), // Navigate to the regions page
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: Column(
        children: [
          CustomSearchBar(
            labelText: 'Search API',
            controller: _apiController,
            onPressed: _searchApi,
          ),
          CustomSearchBar(
            labelText: 'Search Local',
            controller: _localController,
            onPressed: _searchLocal,
          ),
          Button(
            text: 'Areas Near Me',
            onPressed: _getNearbyAreas,
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
          ElevatedButton(
            onPressed: _navigateToRegionsPage,
            child: Text('Regions'),
          ),
        ],
      ),
    );
  }
}
