import 'package:flutter/material.dart';

class TripsPage extends StatefulWidget {
  const TripsPage({super.key});

  @override
  State<TripsPage> createState() => _TripsPageState();
}

class _TripsPageState extends State<TripsPage> {
  final List<Map<String, String>> _trips = [];

  void _addTrip() {
    showDialog(
      context: context,
      builder: (context) {
        final TextEditingController nameController = TextEditingController();
        final TextEditingController dateController = TextEditingController();

        return AlertDialog(
          title: const Text(
            'Add New Trip',
            style: TextStyle(color: Colors.black), // Set text color to black
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Trip Name'),
              ),
              TextField(
                controller: dateController,
                decoration: const InputDecoration(labelText: 'Date'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                final String name = nameController.text;
                final String date = dateController.text;
                if (name.isNotEmpty && date.isNotEmpty) {
                  setState(() {
                    _trips.add({'name': name, 'date': date});
                  });
                  Navigator.of(context).pop();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow,
              ),
              child: const Text(
                'Add',
                style: TextStyle(color: Colors.black),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow,
              ),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trips'),
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: _trips.length,
        itemBuilder: (context, index) {
          final trip = _trips[index];
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white, // White background for each trip
              borderRadius: BorderRadius.circular(8.0), // Rounded corners
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3), // Shadow position
                ),
              ],
            ),
            child: ListTile(
              title: Text(
                trip['name'] ?? '',
                style: const TextStyle(
                  color: Colors.black, // Black text color
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                trip['date'] ?? '',
                style: const TextStyle(
                  color: Colors.black, // Black text for the date
                ),
              ),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/tripDetail',
                  arguments: trip,
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTrip,
        backgroundColor: Colors.yellow,
        child: const Icon(Icons.add),
      ),
    );
  }
}
