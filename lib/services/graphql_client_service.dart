import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:openbeta/services/test_connection_service.dart';

// Set up the GraphQL client with HTTP link and perform test connection
GraphQLClient setupGraphQLClient() {
  final HttpLink httpLink = HttpLink('https://api.openbeta.io/graphql');
  TestConnectionService(httpLink).testConnection();

  return GraphQLClient(
    cache: GraphQLCache(),
    link: httpLink,
  );
}