import 'package:flutter/material.dart';
import 'package:openbeta/effects/splash_screen.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:openbeta/services/my_projects.dart';
import 'package:openbeta/services/graphql_client_service.dart';
import 'package:openbeta/services/initialize_app_service.dart';
import 'package:openbeta/models/routes.dart';

void main() {
  initializeApp().then((_) {
    final GraphQLClient client = setupGraphQLClient();
    runApp(MyApp(client: client));
  });
}

class MyApp extends StatelessWidget {
  final GraphQLClient client;

  const MyApp({required this.client});

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
          routes: Routes.routes, // Use routes from the Routes class
        ),
      ),
    );
  }
}
