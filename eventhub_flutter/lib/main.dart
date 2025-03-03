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

class EventHubApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink('https://your-graphql-endpoint.com/graphql');

    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        link: httpLink,
        cache: GraphQLCache(store: HiveStore()),
      ),
    );

    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: _LandingPage(),
      ),
    );
  }
}

class _LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EventHub'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeroSection(),
            CalendarSection(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EventFormPage()),
                );
              },
              child: Text('Register for Event'),
            ),
          ],
        ),
      ),
    );
  }
}

class HeroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      color: Colors.blueAccent,
      width: double.infinity,
      child: Column(
        children: [
          Text(
            'Welcome to EventHub',
            style: TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            'Your one-stop solution for managing school events seamlessly.',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class CalendarSection extends StatelessWidget {
  final String query = """
    query GetEvents {
      events {
        id
        title
        date
      }
    }
  """;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Query(
        options: QueryOptions(document: gql(query)),
        builder: (result, {fetchMore, refetch}) {
          if (result.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (result.hasException) {
            return Text('Error loading events');
          }

          List events = result.data?['events'] ?? [];

          return Column(
            children: events.map((event) {
              return ListTile(
                title: Text(event['title']),
                subtitle: Text(event['date']),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

class EventFormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Registration'),
      ),
      body: Center(
        child: Text('Form Page Placeholder'),
      ),
    );
  }
}