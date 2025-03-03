import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

ValueNotifier<GraphQLClient> valueNotifier = ValueNotifier<GraphQLClient>(buildClient());

String endpoint = "http://localhost:5264/graphql";

String token = "";

GraphQLClient client = buildClient();

GraphQLClient buildClient() {
  final HttpLink link = HttpLink(
    endpoint,
  
    defaultHeaders: {
      'Authorization': 'Bearer $token',
    }
  );

  GraphQLClient client = GraphQLClient(
    link: link,
    cache: GraphQLCache(store: HiveStore()),
  );

  return client;
}

ValueNotifier<GraphQLClient> getEventHubGraphQLClient() {
  return valueNotifier;
}

void setAuthToken(String authToken) {
  token = authToken;
  buildClient();
  valueNotifier.value = client;
}

void setEndpoint(String graphqlEndpoint) {
  endpoint = graphqlEndpoint;
  buildClient();
  valueNotifier.value = client;
}


/**
 * 
 * FutureBuilder(
              future: authenticate(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text('Authenticating...');
                } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
                } else {
                return Query(
                  options: QueryOptions(
                  document: gql(gqlTest),
                  pollInterval: const Duration(seconds: 10),
                  ),
                  builder: (QueryResult result, {refetch, fetchMore}) {
                  if (result.hasException) {
                    if (result.exception.toString().contains("AUTH_NOT_AUTHENTICATED")) {
                    return const Text('Not authorized');
                    }
                    return Text(result.exception.toString());
                  }

                  if (result.isLoading) {
                    return const Text('Loading');
                  }

                  return Text(result.data?['authConnectionTest'] ?? 'No data');
                  },
                );
                }
              },
              ),
 */