import 'package:flutter/material.dart';
import 'view_deleted_items_page.dart';  // Import the new page

class TripDetailPage extends StatefulWidget {
  const TripDetailPage({super.key});

  @override
  State<TripDetailPage> createState() => _TripDetailPageState();
}

class _TripDetailPageState extends State<TripDetailPage> {
  final List<Map<String, dynamic>> _items = [];
  final List<Map<String, dynamic>> _deletedItems = [];  // List to store deleted items

  void _addItem() {
    final TextEditingController nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Item', style: TextStyle(color: Colors.black),),
          content: TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Item Name'),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                final String name = nameController.text;
                if (name.isNotEmpty) {
                  setState(() {
                    final existingItem = _items.firstWhere(
                          (item) => item['name'] == name,
                      orElse: () => <String, dynamic>{}, // Return an empty map instead of null
                    );

                    if (existingItem.isNotEmpty) {
                      existingItem['count']++;
                    } else {
                      _items.add({
                        'name': name,
                        'timeAdded': DateTime.now(),
                        'count': 1,
                        'checked': false,
                        'timeChecked': null,
                      });
                    }
                  });
                  Navigator.of(context).pop();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow,
              ),
              child: const Text('Add'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
              ),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _deleteItem(int index) {
    final TextEditingController placeController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Item', style: TextStyle(color: Colors.black),),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Are you intentionally keeping this item somewhere?', style: TextStyle(color: Colors.black),),
              TextField(
                controller: placeController,
                decoration: const InputDecoration(labelText: 'Enter place (optional)'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();  // Dismiss dialog if not deleting
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
              ),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  final item = _items.removeAt(index);  // Remove item from the main list
                  item['place'] = placeController.text.isNotEmpty ? placeController.text : 'Unknown';
                  item['timeDeleted'] = DateTime.now();
                  _deletedItems.add(item);  // Add item to the deleted items list
                });
                Navigator.of(context).pop();  // Dismiss dialog
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text('Delete'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  final item = _items.removeAt(index);  // Remove item from the main list
                  item['place'] = placeController.text.isNotEmpty ? placeController.text : 'Unknown';
                  item['timeDeleted'] = DateTime.now();
                  _deletedItems.add(item);  // Add item to the deleted items list
                });
                Navigator.of(context).pop();  // Dismiss dialog
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow,
              ),
              child: const Text('Done'),
            ),
          ],
        );
      },
    );
  }

  void _endTrip() {
    if (_items.isNotEmpty) {
      // Notify user of remaining items
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('You still have ${_items.length} items in your list!'),
        ),
      );
    } else {
      // End the trip
      Navigator.pop(context);
    }
  }

  void _viewDeletedItems() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewDeletedItemsPage(deletedItems: _deletedItems),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, String>? trip = ModalRoute.of(context)?.settings.arguments as Map<String, String>?;

    return Scaffold(
      appBar: AppBar(
        title: Text(trip?['name'] ?? 'Trip Detail'),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: _endTrip,
            icon: const Icon(Icons.check),
            tooltip: 'End Trip',
          ),
          IconButton(
            onPressed: _viewDeletedItems,
            icon: const Icon(Icons.delete),
            tooltip: 'View Deleted Items',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Date: ${trip?['date'] ?? ''}',
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  final item = _items[index];
                  return ListTile(
                    title: Text(
                      '${item['name']} (${item['count']})',
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Added at: ${item['timeAdded']}',
                          style: const TextStyle(color: Colors.white54),
                        ),
                        if (item['timeChecked'] != null)
                          Text(
                            'Checked at: ${item['timeChecked']}',
                            style: const TextStyle(color: Colors.white54),
                          ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.white),
                          onPressed: () {
                            // Implement item editing
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.white),
                          onPressed: () => _deleteItem(index),
                        ),
                      ],
                    ),
                    leading: Checkbox(
                      value: item['checked'],
                      onChanged: (bool? value) {
                        setState(() {
                          item['checked'] = value;
                          if (value == true) {
                            item['timeChecked'] = DateTime.now();
                          } else {
                            item['timeChecked'] = null;
                          }
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addItem,
        backgroundColor: Colors.yellow,
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}