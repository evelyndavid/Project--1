import 'package:flutter/material.dart';
import 'loading_page.dart'; // Import the loading page
import 'trips_page.dart';   // Import the trips page
import 'trip_detail_page.dart';  // Existing trip detail page
import 'view_deleted_items_page.dart';  // Import the new page

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Bag',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.yellow,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.yellow,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
          headlineSmall: TextStyle(color: Colors.white),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.yellow, // Button color
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.yellow,
        ),
        scaffoldBackgroundColor: Colors.black,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.yellow,
          primary: Colors.black,
          onPrimary: Colors.yellow,
          secondary: Colors.yellow,
        ).copyWith(background: Colors.black),
      ),
      home: const LoadingPage(), // Set LoadingPage as the initial screen
      routes: {
        '/trips': (context) => const TripsPage(), // Route to TripsPage
        '/tripDetail': (context) => const TripDetailPage(), // Route to TripDetailPage
        '/viewDeletedItems': (context) => const ViewDeletedItemsPage(deletedItems: []), // Route to ViewDeletedItemsPage
      },
    );
  }
}
