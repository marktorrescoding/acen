import 'package:flutter/material.dart';
import 'package:openbeta/effects/splash_screen.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:openbeta/services/my_projects.dart';
import 'package:openbeta/services/graphql_client_service.dart';
import 'package:openbeta/services/initialize_app_service.dart';
import 'package:openbeta/models/routes.dart';

// Main function: entry point of the application
void main() {
  // Initialize the app and then setup the GraphQL client
  initializeApp().then((_) {
    final GraphQLClient client = setupGraphQLClient();
    // Run the Flutter app by instantiating MyApp class with GraphQL client
    runApp(MyApp(client: client));
  });
}

// Definition of MyApp class which extends StatelessWidget (immutable widget)
class MyApp extends StatelessWidget {
  // Definition of GraphQLClient variable
  final GraphQLClient client;

  // Constructor of MyApp with required parameter client
  const MyApp({required this.client});

  // Overriding the build method of StatelessWidget
  @override
  Widget build(BuildContext context) {
    // ChangeNotifierProvider is an implementation of a simple dependency injection
    // Here it is providing an instance of MyProjects which can be accessed by its descendants
    return ChangeNotifierProvider(
      create: (_) => MyProjects(),
      child: GraphQLProvider(
        // ValueNotifier is a simple kind of StreamBuilder
        // Here it is used to provide an instance of GraphQLClient to descendants
        client: ValueNotifier(client),
        child: MaterialApp(
          // App name
          title: 'Climbing App',
          // Global theme of the app
          theme: ThemeData(
            primarySwatch: Colors.green,
          ),
          // First screen of the app when launched
          home: SplashScreen(),
          // The app's route table
          routes: Routes.routes,
        ),
      ),
    );
  }
}
