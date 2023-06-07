import 'package:flutter/material.dart';
import 'package:openbeta/pages/home_page/home_page.dart';
import 'package:openbeta/effects/splash_screen.dart';
import 'package:openbeta/services/test_connection_service.dart';
import 'package:graphql/client.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() {
  // Initialize HttpLink with your GraphQL endpoint.
  final HttpLink httpLink = HttpLink('https://api.openbeta.io/graphql');
  TestConnectionService(httpLink).testConnection(); // call the testConnection method

  // Pass your HttpLink to the client
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
    return GraphQLProvider(
      client: ValueNotifier(client),
      child: MaterialApp(
        title: 'Climbing App',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: SplashScreen(), // Set the SplashScreen as the initial screen
        routes: {
          '/home': (context) => HomePage(),
        },
      ),
    );
  }
}
