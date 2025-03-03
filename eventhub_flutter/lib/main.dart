import 'package:eventhub_flutter/graphql/graphql.dart';
import 'package:eventhub_flutter/pages/landing.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';


void main() async {
  await initHiveForFlutter();
  await initializeDateFormatting("de_DE");
  runApp(const EventHub());
}

class EventHub extends StatelessWidget {
  const EventHub({super.key});

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: getEventHubGraphQLClient(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LandingPage(),
      ),
    );
  }
}