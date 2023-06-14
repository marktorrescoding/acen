import 'package:flutter/material.dart';
import 'package:openbeta/pages/home_page/home_page.dart';
import 'package:openbeta/effects/splash_screen.dart';
import 'package:openbeta/services/test_connection_service.dart';
import 'package:graphql/client.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:openbeta/models/area.dart';
import 'package:provider/provider.dart';
import 'package:openbeta/services/my_projects.dart';  // Assuming that MyProjects class is defined here

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(AreaAdapter());
  final HttpLink httpLink = HttpLink('https://api.openbeta.io/graphql');
  TestConnectionService(httpLink).testConnection();

  final GraphQLClient client = GraphQLClient(
    cache: GraphQLCache(),
    link: httpLink,
  );

  runApp(MyApp(client: client));
}

class MyApp extends StatelessWidget {
  final GraphQLClient client;

  MyApp({required this.client});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MyProjects(),
      child: GraphQLProvider(
        client: ValueNotifier(client),
        child: MaterialApp(
          title: 'Climbing App',
          theme: ThemeData(
            primarySwatch: Colors.green,
          ),
          home: SplashScreen(),
          routes: {
            '/home': (context) => HomePage(),
          },
        ),
      ),
    );
  }
}

